############################################################
#
# Name:       Chad Ohl
# Assignment: Maze Final
# Date:       6/10/14
# Class:      CIS 283
#
############################################################

class Maze
  def initialize(filename)
    maze_file = File.open(filename, "r")

    @maze = []
    maze_file.each { |row|
      @maze << row.chomp.split("")
    }

    maze_file.close
  end

  def solve
    def find_f(mz)
      f_found = false
      f_row = 0
      f_col = 0

      @maze.each { |row| #Each row
        f_col = 0
        row.each { |col| #Each character of current row
          if col == "F"
            f_found = true
            break
          end

          f_col += 1
        }
        if f_found
          break
        end
        f_row += 1
      }
      return f_location = [f_row, f_col]
    end

    def find_s(mz)
      s_found = false
      s_row = 0
      s_col = 0

      @maze.each { |row| #Each row
        s_col = 0
        row.each { |col| #Each character of current row
          if col == "S"
            s_found = true
            break
          end

          s_col += 1
        }
        if s_found
          break
        end
        s_row += 1

      }
      return s_location = [s_row, s_col]
    end

    f_location = find_f(@maze) #Finding F Location
    s_location = find_s(@maze) #Finding S Location

    if f_location[0] - 1 >= 0 && @maze[f_location[0] - 1][f_location[1]] == " " #NORTH
      @maze[f_location[0] - 1][f_location[1]] = 0
    end
    if f_location[0] + 1 < @maze.length && @maze[f_location[0] + 1][f_location[1]] == " " #SOUTH
      @maze[f_location[0] + 1][f_location[1]] = 0
    end
    if f_location[1] + 1 < @maze[0].length && @maze[f_location[0]][f_location[1] + 1] == " " #EAST
      @maze[f_location[0]][f_location[1] + 1] = 0
    end
    if f_location[1] - 1 >= 0 && @maze[f_location[0]][f_location[1] - 1] == " " #WEST
      @maze[f_location[0]][f_location[1] - 1] = 0
    end

    solved = false
    unsolvable = false
    count = 0

    while @maze[s_location[0] - 1][s_location[1]] != count && @maze[s_location[0] + 1][s_location[1]] != count &&
        @maze[s_location[0]][s_location[1] - 1] != count && @maze[s_location[0]][s_location[1] + 1] != count && unsolvable == false || solved

      current_row = 0
      @maze.each { |row| #Each row
        current_col = 0
        row.each { |col| #Each character of current row
          if col == count
            if  current_row - 1 >= 0 && @maze[current_row - 1][current_col] == " " #NORTH
              @maze[current_row - 1][current_col] = count + 1
            end

            if  current_row + 1 < @maze.length && @maze[current_row + 1][current_col] == " " #SOUTH
              @maze[current_row + 1][current_col] = count + 1
            end

            if current_col + 1 < @maze[0].length && @maze[current_row][current_col + 1] == " " #EAST
              @maze[current_row][current_col + 1] = count + 1
            end

            if  current_col - 1 >= 0 && @maze[current_row][current_col - 1] == " " #WEST
              @maze[current_row][current_col - 1] = count + 1
            end
          end

          current_col += 1
        }
        current_row += 1
      }

      blocked = []
      @maze.each { |row|
        blocked << row.include?(count + 1)
      }

      if !blocked.include?(true)
        unsolvable = true
      end

      count += 1
    end

    steps = count + 1

    if @maze[s_location[0] - 1][s_location[1]] == count || @maze[s_location[0] + 1][s_location[1]] == count ||
        @maze[s_location[0]][s_location[1] - 1] == count || @maze[s_location[0]][s_location[1] + 1] == count

      if s_location[0] - 1 >= 0 && @maze[s_location[0] - 1][s_location[1]] == count #NORTH
        @maze[s_location[0] - 1][s_location[1]] = '*'
      elsif s_location[0] + 1 < @maze.length && @maze[s_location[0] + 1][s_location[1]] == count #SOUTH
        @maze[s_location[0] + 1][s_location[1]] = '*'
      elsif s_location[1] + 1 < @maze[0].length && @maze[s_location[0]][s_location[1] + 1] == count #EAST
        @maze[s_location[0]][s_location[1] + 1] = '*'
      elsif s_location[1] - 1 >= 0 && @maze[s_location[0]][s_location[1] - 1] == count #WEST
        @maze[s_location[0]][s_location[1] - 1] = '*'
      end

      while count >= 0
        current_row = 0
        @maze.each { |row| #Each row
          current_col = 0
          row.each { |col| #Each character of current row
            if col == '*' && (current_row - 1 >= 0 && @maze[current_row - 1][current_col] == count ||
                current_row + 1 < @maze.length && @maze[current_row + 1][current_col] == count ||
                current_col + 1 < @maze[0].length && @maze[current_row][current_col + 1] == count ||
                current_col - 1 >= 0 && @maze[current_row][current_col - 1] == count)

              if  current_row - 1 >= 0 && @maze[current_row - 1][current_col] == count #NORTH
                @maze[current_row - 1][current_col] = '*'
              elsif  current_row + 1 < @maze.length && @maze[current_row + 1][current_col] == count #SOUTH
                @maze[current_row + 1][current_col] = '*'
              elsif current_col + 1 < @maze[0].length && @maze[current_row][current_col + 1] == count #EAST
                @maze[current_row][current_col + 1] = '*'
              elsif  current_col - 1 >= 0 && @maze[current_row][current_col - 1] == count #WEST
                @maze[current_row][current_col - 1] = '*'
              end
            end
            current_col += 1
          }
          current_row += 1
        }

        count -= 1
      end
    end

    current_row = 0
    @maze.each { |row|
      current_col = 0
      row.each { |col|
        if col.is_a?(Integer)
          @maze[current_row][current_col] = ' '
        end
        current_col += 1
      }
      current_row += 1
    }

    if unsolvable
      return "This maze is unsolvable! It took #{steps} to find this out!"
    else
      return "This maze took #{steps} steps to complete!"
    end


  end

  def print
    ret_str = ""
    @maze.each { |row|
      ret_str += row.join("") + "\n"
    }

    return ret_str
  end
end

def menu
  menu_str = "1) Solve Maze 1\n2) Solve Maze 2\n3) Solve Maze 3\n"\
             "4) Solve Maze 4\n5) Solve Maze 5\n6) Solve Maze 6\n"\
             "7) Solve Maze 7\n8) Solve Maze 8\n9) Solve Maze 9\n"\
             "10) Solve Maze 10\n11) Quit"
  return menu_str
end

#######MENU STUFF#######
user_choice = 0

while user_choice != 11
  puts menu
  print 'Enter a selection:'
  user_choice = gets.to_i

  if user_choice.between?(1, 10)
    maze = Maze.new("maze#{user_choice}.mz")
    puts maze.print
    print "Solving..."
    puts maze.solve
    puts maze.print
    print "Press any key to return to menu..."
    gets
  end
end