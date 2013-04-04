
all: target/lib/dsdgen.jar target/tpcds-mr-1.0-SNAPSHOT.jar

target/tpcds-mr-1.0-SNAPSHOT.jar: $(find -name *.java) 
	mvn package

target/tpcds_kit.zip: tpcds_kit.zip
	mkdir -p target/
	cp tpcds_kit.zip target/tpcds_kit.zip

tpcds_kit.zip:
	curl --output tpcds_kit.zip http://www.tpc.org/tpcds/dsgen/dsgen-download-files.asp?download_key=NaN

target/lib/dsdgen.jar: target/tools/dsdgen
	cd target/; mkdir -p lib/; jar cvf lib/dsdgen.jar tools/

target/tools/dsdgen: target/tpcds_kit.zip
	cd target; unzip tpcds_kit.zip
	cd target/tools; make clean; make

clean:
	mvn clean
