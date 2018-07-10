#TOPletter class 
_version 0.3.0 of 2018/07/10_

Copyright 2015 Marco Torchiano  
Apache License 2.0 

The TOPletter bundle contains everything is needed for typesetting a letter using LaTeX and conforming to the official [Corporate Image](http://www.politocomunica.polito.it/corporate_image/marchio_e_identita_visiva) guidelines for [Politecnico di Torino](http://www.polito.it). The template can be used for letter both in Italian and English.

To understand how you can write an official letter, [here](https://github.com/mtorchiano/TOPLetter/blob/master/EsempioLettera.tex) is the source for the letter and [here](https://github.com/mtorchiano/TOPLetter/raw/master/EsempioLettera.pdf) you can see the result.

Installation
------------

Currently *TOPletter* is not yet on [CTAN](https://ctan.org/).

You can download the [local release](https://github.com/mtorchiano/TOPLetter/releases/tag/v0.3.0local), expand the contents in one of your folder and start drafting your corporate letters.

You can start with the sample letters provided in the release.

Usage
-----

The usage of the document class is extremely straightforward:

* the *TOPletteré document class must be declared as the base for the document.

    i.e. using `\documentclass{TOPletterA}`.

* the customization macros must be used to define the details of the letter,

    i.e. organization details, personal information, and letter subject.
* the body of the letter can be written as a regular *LATEX* document.


### Organizational Unit

* The name of the department can be specified using the `\dipartimentoDi{⟨department name⟩}` macro.

* By default the organizational unit is a department, but it is possible to set the type of the organizational unit using `\struttura{⟨structure type⟩}` macro.

### Personal Info

* `\nome{⟨name and surname⟩}` Defines the name of the person, it should include both first and last names as they will appear in the header of the letter and at the end of the letter (after the date).
* `\ruolo{⟨role⟩}` defines the role of the person, e.g. *Full Professor*. 
* `\telefono{⟨phone number⟩}` defines the office phone number.
* `\email{⟨email⟩}` defines the email address of the person

The above information is mandatory and an error is reported if any is missing.

* `\homepage{⟨url⟩}` defines the (optional) URL of the personal home page. 
* `\fax{⟨fax ⟩}` defines the (optional) fax number.
* `\firma{⟨image file⟩}` defines an image file (typically a PNG) that contains a scanned signature of the person.

### Letter Details

* `\soggetto{⟨subject⟩}` defines the subject of the letter, that will appear, at the top of the letter preceded by the word ”Subject:” (or ”Soggetto:” if the language is italian).
* 
The above macro is the only mandatory for the letter details. 

* `\destinatario{⟨recipient⟩}` defines the recipient of the letter, if no recipient is provided the letter will be addressed to ”*To whom it may concern*” (or ”*A chi di competenza*” if the languaga is italian).
* `\luogo{⟨place⟩}` defines the place that accompanies the date, it is by default ”*Torino*”
* `\data{⟨date⟩}` defines a date to be used at the bottom of the letter instead of the current date.
* `\esoggetto{⟨label⟩}` changes the word that precedes the subject topic, replaces the default ”*Subject:*” (or "*Oggetto:*" if the language is italian).
* `\protocollo{⟨label⟩}` define a protol number; if empty, only the “Prot:” will appear at top left.

### Logo

* `\logo{⟨image file⟩}` defines the image file containing the logo used in the header of the letter. The logo must be square with at least 400x400 pixel resolution. The default is the Politecnico di Torino logo.

### Language

The document language can be specified as either italian or english as class parameter e.g. as `\documentclass[italian]{TOPletter}`. The default language is italian.

The language can be detected using the `\IfLanguageName` macro to adapt the document contents to the specific language. This can be useful if a template file is used for both languages, for instance if we want to adapt the OU type and name according to the language we can add in the tex file the following:
```
 \IfLanguageName{italian}{ %% department italian name:
    \dipartimentoDi{Automatica e Informatica}
 }{%% department english name:
   \dipartimentoDi{Control and Computer Engineering}
 }
 ```
Automatically, based on the document language (defined as *documentclass* parameter), the correct naming for the department will be used.

Example
-------

Here is a very basic example of a short template used for writing a bilingual letter.

```{latex}\documentclass[english]{TOPletter}
%% Load any additional package
\usepackage{lipsum}
\IfLanguageName{italian}{ %% italian names
  \dipartimentoDi{Disegno e Animazione}
  \ruolo{Produttore}
}{%% english names
  \dipartimentoDi{Comics and Cartoons}
  \ruolo{Producer}
}
%% personal details
\nome{Walt DISNEY}
\telefono{+1 555 123 4567}
\email{walt.disney@polito.it}
\homepage{http://www.polito.it/wdisney/}
%% Subject
\soggetto{Sample letter}
\begin{document}
%% Letter content
This is the typical appearance of a PoliTo letter.
\lipsum
\end{document}
```