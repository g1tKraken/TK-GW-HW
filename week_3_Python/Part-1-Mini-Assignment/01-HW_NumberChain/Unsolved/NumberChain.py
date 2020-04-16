# Initial variable to track game play

userconcent = True

# Set start and last number
# Ask the user how many numbers to loop through
userIn = input("To start, input a number, any number, and watch the magic! : ")
startAt = 0

# While we are still playing...
while userconcent:
    loopTo = int(userIn)         
    # Loop through the numbers. (Be sure to cast the string into an integer.)
    for i in range(startAt, loopTo) :
        # Print each number in the range
        print(f"[{i}]")

    # Set the next start number as the last number of the loop
    startAt = loopTo
    
    # Once complete... ask if the user wants to continue
    userIn = input("Enter another number or enter \"n\" : ")
    if userIn == "n":
        userconcent = False
    elif userIn == "y":
        userIn = input("Then enter a number please! You could have skipped this step... just saying... : ")
        userIn = startAt + int(userIn)
    else:
        userIn = startAt + int(userIn)






   

 






