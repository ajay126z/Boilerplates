cd ./03_reports

for file in *.out; do
    echo "Running --> " "$file"
    ./"$file" > "$file.txt"

    status=$( tail -n 1 "$file.txt" )
    echo "Test Result -" "$status"
    echo " "

done

cd ..
make -f RunTests.mk move