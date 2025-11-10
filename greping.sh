# Option 1: Using brace expansion
grep 'Excited State' {dimer_V12/Dimer_V12,monomer_{1,2,3}/Monomer_{1,2,3}}_Starting_Materials_exst.log
# OR
grep 'Excited State' {dimer_V12/Dimer_V12,monomer_*/Monomer_*}_Starting_Materials_exst.log

# Option 2: Using a simple loop
for dir in dimer_V12 monomer_1 monomer_2 monomer_3;
    do grep 'Excited State' $dir/*_Starting_Materials_exst.log;
done

# OR
for f in dimer_V12/Dimer_V12_Starting_Materials_exst.log monomer_{1..3}/Monomer_{1..3}_Starting_Materials_exst.log;
    do grep 'Excited State' "$f" || break;
done

# Option 3: Using find (most flexible)
find . -name "*_Starting_Materials_exst.log" -path "*/dimer_V12/*" -o -path "*/monomer_*/*" | xargs grep 'Excited State'

# Option 4: Simple wildcard approach
grep 'Excited State' */*/Starting_Materials_exst.log

# Grepping and Formating Columns 
grep 'Excited State' Single_Material_exst.log | awk '{   
       # Extract the energy value (always the 5th column by default space separation) and round it
    energy = sprintf("%.2f", $5);
    # Use gsub to find and replace the f= value with a rounded version
    # This pattern looks for "f=" followed by a number and captures the number part
    match($0, /f=([0-9.]+)/, arr);
    if (arr[1] != "") {
      f_value = sprintf("%.2f", arr[1]);
      # Replace the original value with the new rounded one in the current line ($0)
      # The [0-9.]+ matches one or more digits or dots
      gsub(/f=[0-9.]+/, "f=" f_value);
    }
    # Replace the original energy value in $0 with the rounded one
    # Use a similar robust method to find and replace the energy value itself
    gsub(/[0-9.]+\s*eV/, energy " eV");
    print $0;
}'
