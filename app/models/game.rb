class Game < ApplicationRecord
  before_validation(on: :create) do
    self.state = {
      0 => { 0 => nil, 1 => nil, 2 => nil },
      1 => { 0 => nil, 1 => nil, 2 => nil },
      2 => { 0 => nil, 1 => nil, 2 => nil },
    }
    self.current_symbol = 'x'
    self.filled = 0
    self.win_sym = nil
    self.user_id = nil
  end

  after_update_commit { broadcast_update }

  def set_user_id(id)
    self.user_id = id
    self.save!
  end

  def field
    [self[0, 0], self[0, 1], self[0, 2], 
     self[1, 0], self[1, 1], self[1, 2], 
     self[2, 0], self[2, 1], self[2, 2]]
  end

  def first_row
    [self[0, 0], self[0, 1], self[0, 2]]
  end

  def second_row
    [self[1, 0], self[1, 1], self[1, 2]]
  end

  def third_row
    [self[2, 0], self[2, 1], self[2, 2]]
  end

  def first_col
    [self[0, 0], self[1, 0], self[2, 0]]
  end

  def second_col
    [self[0, 1], self[1, 1], self[2, 1]]
  end

  def third_col
    [self[0, 2], self[1, 2], self[2, 2]]
  end

  def first_diag
    [self[0, 0], self[1, 1], self[2, 2]]
  end

  def second_diag
    [self[0, 2], self[1, 1], self[2, 0]]
  end

  def game_over?
    if self.first_row == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    end

    if self.first_row == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.second_row == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.second_row == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.third_row == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.third_row == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.first_col == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.first_col == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.second_col == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.second_col == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.third_col == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.third_col == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.first_diag == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.first_diag == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.second_diag == %w[x x x]
      self.update_column(:win_sym, 'x')
      return true
    elsif self.second_diag == %w[o o o]
      self.update_column(:win_sym, 'o')
      return true
    end

    if self.filled == 9 && win_sym.nil?
      self.win_sym = 'draw'
      self.save!
      return true
    end
  end

  def [](row, col)
    state[row.to_s][col.to_s]
  end

  def move!(row, col)
    state[row.to_s][col.to_s] = current_symbol
    self.filled += 1
    self.current_symbol = current_symbol == "x" ? "o" : "x"
    self.save!
  end

  def ai_move!
    row = col = nil

    #draw strategy
    if self.field == [nil, nil, nil, 
                      nil, 'x', nil, 
                      nil, nil, nil]
      row = col = 0
    elsif self.field == ['o', nil, 'x', 
                         nil, 'x', nil, 
                         nil, nil, nil]
      row = 2
      col = 0
    elsif self.field == ['o', nil, 'x', 
                         'x', 'x', nil, 
                         'o', nil, nil]
      row = 1
      col = 2
    elsif self.field == ['o', 'x', 'x', 
                         'x', 'x', 'o', 
                         'o', nil, nil]
      row = 2
      col = 1

    #draw strategy
    elsif self.field == ['x', nil, nil, 
                         nil, nil, nil, 
                         nil, nil, nil]
      row = col = 1
    elsif self.field == ['x', nil, nil, 
                         nil, 'o', nil, 
                         nil, nil, 'x']
      row = 1
      col = 0
    elsif self.field == ['x', nil, nil, 
                         'o', 'o', 'x', 
                         nil, nil, 'x']
      row = 0
      col = 2
    elsif self.field == ['x', nil, 'o', 
                         'o', 'o', 'x', 
                         'x', nil, 'x']
      row = 0
      col = 1

    #draw strategy
    elsif self.field == ['x', nil, 'o', 
                         'o', 'o', 'x', 
                         'x', nil, 'x']
      row = 2
      col = 1

    #win situations

    #for rows (mid)
    elsif self.first_row == ['o', nil, 'o']
      row = 0
      col = 1
    elsif self.second_row == ['o', nil, 'o']
      row = 1
      col = 1
    elsif self.third_row == ['o', nil, 'o']
      row = 2
      col = 1

    #for rows (left)
    elsif self.first_row == [nil, 'o', 'o']
      row = 0
      col = 0
    elsif self.second_row == [nil, 'o', 'o']
      row = 1
      col = 0
    elsif self.third_row == [nil, 'o', 'o']
      row = 3
      col = 0

    #for rows (right)
    elsif self.first_row == ['o', 'o', nil]
      row = 0
      col = 2
    elsif self.second_row == ['o', 'o', nil]
      row = 1
      col = 2
    elsif self.third_row == ['o', 'o', nil]
      row = 3
      col = 2

    #for cols (mid)
    elsif self.first_col == ['o', nil, 'o']
      row = 1
      col = 0
    elsif self.second_col == ['o', nil, 'o']
      row = 1
      col = 1
    elsif self.third_col == ['o', nil, 'o']
      row = 1
      col = 2

    #for cols (left)
    elsif self.first_col == [nil, 'o', 'o']
      row = 0
      col = 0
    elsif self.second_col == [nil, 'o', 'o']
      row = 0
      col = 1
    elsif self.third_col == [nil, 'o', 'o']
      row = 0
      col = 2

    #for cols (right)
    elsif self.first_col == ['o', 'o', nil]
      row = 2
      col = 0
    elsif self.second_col == ['o', 'o', nil]
      row = 2
      col = 1
    elsif self.third_col == ['o', 'o', nil]
      row = 2
      col = 2

    #for diags (mid)
    elsif self.first_diag == ['o', nil, 'o']
      row = col = 1
    elsif self.second_diag == ['o', nil, 'o']
      row = col = 1

    #for diags (left)
    elsif self.first_diag == [nil, 'o', 'o']
      row = col = 0
    elsif self.second_diag == [nil, 'o', 'o']
      row = 0
      col = 2

    #for diags (right)
    elsif self.first_diag == ['o', 'o', nil]
      row = col = 2
    elsif self.second_diag == ['o', 'o', nil]
      row = 2
      col = 0

    #general situations

    #for rows (mid)
    elsif self.first_row == ['x', nil, 'x'] || self.first_row == ['o', nil, 'o']
      row = 0
      col = 1
    elsif self.second_row == ['x', nil, 'x'] || self.second_row == ['o', nil, 'o']
      row = 1
      col = 1
    elsif self.third_row == ['x', nil, 'x'] || self.third_row == ['o', nil, 'o']
      row = 2
      col = 1

    #for rows (left)
    elsif self.first_row == [nil, 'x', 'x'] || self.first_row == [nil, 'o', 'o']
      row = 0
      col = 0
    elsif self.second_row == [nil, 'x', 'x'] || self.second_row == [nil, 'o', 'o']
      row = 1
      col = 0
    elsif self.third_row == [nil, 'x', 'x'] || self.third_row == [nil, 'o', 'o']
      row = 3
      col = 0

    #for rows (right)
    elsif self.first_row == ['x', 'x', nil] || self.first_row == ['o', 'o', nil]
      row = 0
      col = 2
    elsif self.second_row == ['x', 'x', nil] || self.second_row == ['o', 'o', nil]
      row = 1
      col = 2
    elsif self.third_row == ['x', 'x', nil] || self.third_row == ['o', 'o', nil]
      row = 3
      col = 2

    #for cols (mid)
    elsif self.first_col == ['x', nil, 'x'] || self.first_col == ['o', nil, 'o']
      row = 1
      col = 0
    elsif self.second_col == ['x', nil, 'x'] || self.second_col == ['o', nil, 'o']
      row = 1
      col = 1
    elsif self.third_col == ['x', nil, 'x'] || self.third_col == ['o', nil, 'o']
      row = 1
      col = 2

    #for cols (left)
    elsif self.first_col == [nil, 'x', 'x'] || self.first_col == [nil, 'o', 'o']
      row = 0
      col = 0
    elsif self.second_col == [nil, 'x', 'x'] || self.second_col == [nil, 'o', 'o']
      row = 0
      col = 1
    elsif self.third_col == [nil, 'x', 'x'] || self.third_col == [nil, 'o', 'o']
      row = 0
      col = 2

    #for cols (right)
    elsif self.first_col == ['x', 'x', nil] || self.first_col == ['o', 'o', nil]
      row = 2
      col = 0
    elsif self.second_col == ['x', 'x', nil] || self.second_col == ['o', 'o', nil]
      row = 2
      col = 1
    elsif self.third_col == ['x', 'x', nil] || self.third_col == ['o', 'o', nil]
      row = 2
      col = 2

    #for diags (mid)
    elsif self.first_diag == ['x', nil, 'x'] || self.first_diag == ['o', nil, 'o']
      row = col = 1
    elsif self.second_diag == ['x', nil, 'x'] || self.second_diag == ['o', nil, 'o']
      row = col = 1

    #for diags (left)
    elsif self.first_diag == [nil, 'x', 'x'] || self.first_diag == [nil, 'o', 'o']
      row = col = 0
    elsif self.second_diag == [nil, 'x', 'x'] || self.second_diag == [nil, 'o', 'o']
      row = 0
      col = 2

    #for diags (right)
    elsif self.first_diag == ['x', 'x', nil] || self.first_diag == ['o', 'o', nil]
      row = col = 2
    elsif self.second_diag == ['x', 'x', nil] || self.second_diag == ['o', 'o', nil]
      row = 2
      col = 0
    else
      loop do
        row = rand(0..2)
        col = rand(0..2)
        break if self[row, col].nil?
      end
    end

    state[row.to_s][col.to_s] = current_symbol
    self.filled += 1
    self.current_symbol = current_symbol == "x" ? "o" : "x"
    self.save!
  end
end
