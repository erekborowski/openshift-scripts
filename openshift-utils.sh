#!/bin/bash

# A function to print the selection list
printList() {
  local array=("$@")
  echo "Please select one of the following items:"
  for i in "${!array[@]}"; do
    echo "$((i+1))) ${array[i]}"
  done
}

# A function to get the user's choice and validate it
getChoice() {
  local array=("$@")
  local choice
  read -p "Enter the $choiceName: " choice
  # The valid range is from 1 to the length of the array
  while [[ ! $choice =~ ^[1-${#array[@]}]$ ]]; do
    echo "Invalid $choiceName. Please try again."
    # Reprint the selection list
    printList "${array[@]}"
    read -p "Enter the $choiceName: " choice
  done
  echo "$choice"
}

# A function that accepts an array and a choice name and returns the selected string
selectString() {
  local array=("$@")
  local choiceName=${array[-1]} # The last element of the array is the choice name
  unset array[-1] # Remove the last element from the array
  local selectedString
  # Print the selection list for the first time
  printList "${array[@]}"
  # Get the user's choice
  local choice=$(getChoice "${array[@]}")
  # Store the selected string in a variable
  selectedString=${array[choice-1]}
  # Return the selected string
  echo "$selectedString"
}

# A bash array with several string values
array=("apple" "banana" "cherry" "date" "elderberry" "fig" "grape" "honeydew" "kiwi" "lime")

# Call the selectString function with the array and the choice name and store the output
selectedString=$(selectString "${array[@]}" "fruit")

# Print the selected string
echo "You selected: $selectedString"
