#!/usr/bin/env node

import express from "express";
import bodyParser from "body-parser";
import readlineSync from 'readline-sync'
import fs from 'fs'
import path from 'path'

const app = express()
const port = 10043

const args = {
	number: readlineSync.questionInt('How many problems?: ', {default: 1}),
	text: readlineSync.keyInYNStrict('Add txt files?'),
	// otras opciones si es necesario
};

const curDirectory = process.cwd();

var iterations = 0;

app.use(bodyParser.json());

app.post('/', (req, res) => {
	const data = req.body;
	
	processProblem(data);

	iterations++;

	if(iterations == args.number){
		process.exit(0);
	}

	res.sendStatus(200);
})

const main = () => {
	app.listen(port, (err) => {
		if(err) {
			console.error(err);
			process.exit(1);
		}
		console.log(`Listening... \n\n`);
	})
};

main();

const processProblem = (dataJson) => {
	if(dataJson){
		try{
			const problemName = dataJson.name.split(/[ .:-]/)[0];
			const newDir = path.join(curDirectory, problemName);

			console.log(`Creating problem ${problemName}...`);

			if(!fs.existsSync(newDir)){
				fs.mkdirSync(newDir);
			}else{
				console.log(`The directory ${newDir} already exists.`);
			}

			const newFile = `${problemName}.cpp`;
			fs.writeFileSync(path.join(newDir, newFile), '');

			console.log('Saving Samples...');
			fs.writeFileSync(path.join(newDir, 'in'), dataJson.tests.map((test) => test.input).join('$\n') + "$\n");
			fs.writeFileSync(path.join(newDir, 'out'), dataJson.tests.map((test) => test.output).join('$\n') + "$\n");

			if(args.text){
				fs.writeFileSync(path.join(newDir, 'input.txt'), dataJson.tests.map((test) => test.input).join('\n'));
				fs.writeFileSync(path.join(newDir, 'output.txt'), dataJson.tests.map((test) => test.output).join('\n'));
			}
			
		}catch(error){
			console.error('Error processing JSON: ', error);
		}
	}
}
