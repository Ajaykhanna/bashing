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