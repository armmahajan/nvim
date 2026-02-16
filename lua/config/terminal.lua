-- Floating terminal that always opens in Neovim's startup directory
local M = {}

-- Capture the directory Neovim started in (before any :cd changes it)
local startup_dir = vim.fn.getcwd()

local buf = nil
local win = nil

local function win_opts()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  return {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  }
end

local function create_float()
  buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, true, win_opts())
  vim.fn.jobstart(vim.o.shell, { term = true, cwd = startup_dir })
  vim.cmd("startinsert")
end

function M.toggle()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_hide(win)
    win = nil
    return
  end

  if buf and vim.api.nvim_buf_is_valid(buf) then
    win = vim.api.nvim_open_win(buf, true, win_opts())
    vim.cmd("startinsert")
  else
    create_float()
  end
end

vim.keymap.set("n", "<leader>t", M.toggle, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<C-q>", M.toggle, { desc = "Toggle floating terminal" })

-- Run command: first use prompts for a command, subsequent uses rerun it
local run_buf = nil
local run_win = nil
local run_cmd = nil

local function run_command(cmd)
  -- Clean up old buffer
  if run_buf and vim.api.nvim_buf_is_valid(run_buf) then
    vim.api.nvim_buf_delete(run_buf, { force = true })
  end

  run_buf = vim.api.nvim_create_buf(false, true)
  run_win = vim.api.nvim_open_win(run_buf, true, win_opts())
  vim.fn.jobstart(cmd, { term = true, cwd = startup_dir })
  vim.cmd("startinsert")
end

function M.run()
  -- If the run float is currently visible, just close it
  if run_win and vim.api.nvim_win_is_valid(run_win) then
    vim.api.nvim_win_hide(run_win)
    run_win = nil
    return
  end

  if run_cmd then
    run_command(run_cmd)
  else
    vim.ui.input({ prompt = "Command: " }, function(input)
      if not input or input == "" then return end
      run_cmd = input
      run_command(run_cmd)
    end)
  end
end

vim.keymap.set("n", "<leader>rr", M.run, { desc = "Run command" })
vim.keymap.set("t", "<C-q>", function()
  -- Close whichever float is open
  if run_win and vim.api.nvim_win_is_valid(run_win) then
    vim.api.nvim_win_hide(run_win)
    run_win = nil
  elseif win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_hide(win)
    win = nil
  end
end, { desc = "Close floating terminal" })

return M
