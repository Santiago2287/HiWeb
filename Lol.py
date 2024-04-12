from flask import Flask, render_template, url_for, request, redirect, flash, session


session['username'] = 'admin'
print(session['username'])