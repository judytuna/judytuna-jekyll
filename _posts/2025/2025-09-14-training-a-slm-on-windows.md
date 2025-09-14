---
layout: post
title: "fine-tuning a Phi3.5 SLM on Windows via WSL to make a chatbot that sounds like me"
date: 2025-09-14 14:42:00 -0700
categories: [coding, projects]
tags: [ai, cuda]
---

hahahahaha

ok the plan is: 1. take my blog posts and turn them into paired data. 2. fine-tune a SLM. 3. chat with myself

starting with this tutorial:https://robkerr.ai/fine-tuning-llms-using-a-local-gpu-on-windows/

opened powershell in administrator. typed wsl --install. it didn't give me any trouble. typed wsl. got...

![wsl fail lol]({{ '/assets/images/2025/09/wsl-fail.png' | relative_url }})

https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-1---enable-the-windows-subsystem-for-linux

that worked

![dl ubuntu]({{ '/assets/images/2025/09/downloading-ubuntu.png' | relative_url }})

then

![c++ compiler installed successfully]({{ '/assets/images/2025/09/cplusplus-compiler-installed.png' | relative_url }})

installing miniconda

xformers caused me to have an unresolvable environment, so i removed it and ran

`conda install pytorch-cuda=12.1 pytorch cudatoolkit -c pytorch -c nvidia`

and i think that's the end of how far i'll follow this tutorial, cuz i don't think i'm using unsloth.

i am using ollama!

`curl https://ollama.ai/install.sh | sh`

`pip install -r requirements.txt`

oh god WSL was like "you can't flyer me, i quit"

![catastrophic failure]({{ '/assets/images/2025/09/catastrophic-failure.png' | relative_url }})

anyway then a day passed wherein i ran train_model.py 6 times and it did not change the conversation style at all

* run 5 was gonna take an estimated 1000 hours, which is like 41 days (all data: n-grams for n=1,2,3)
* run 6 was gonna take 240 hours, which is 10 days (medium data: 20% sampline of the n-grams)
* run 7 is estimated to take 20ish hours LOL yay! (lite data: no n-grams rofl. 12,299 pairs of training data (the other 20% are validation pairs), filesize 8.4MB)

now we are at 2% progress on this 7th try haha:

![7th run 2% progress]({{ '/assets/images/2025/09/try7-lite-2percent.png' | relative_url }})