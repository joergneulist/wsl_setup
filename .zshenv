for f in $(ls -1 ~/.env.d)
do
	source ~/.env.d/$f
done
