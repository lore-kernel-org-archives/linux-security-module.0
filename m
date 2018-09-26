From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 26 Sep 2018 23:39:03 +0100
Subject: Leaking path for set_task_comm
In-Reply-To: <20180926031645.GB3321@thunk.org>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
	<20180925183953.GI15710@uranus>
	<0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
	<20180926031645.GB3321@thunk.org>
Message-ID: <20180926233903.38fb598a@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> Trying to depend on task name for anything security sensitive is at
> _really_ bad idea, so it seems unlikely that a LSM would want to
> protect the process name.  (And if they did, the first thing I would
> ask is "Why?  What are you trying to do?  Do you realize how many
> *other* ways the process name can be spoofed or otherwise controlled
> by a potentially malicious user?")

Two processes that should not be able to otherwise communicate can keep
changing their name to a chunk of data, waiting for an ack flag name
change back.

Alan
