From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 13 Aug 2018 12:20:14 -0700
Subject: BUG: Mount ignores mount options
In-Reply-To: <alpine.LRH.2.21.1808140458040.23296@namei.org>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
	<28045.1533916438@warthog.procyon.org.uk>
	<20180810161400.GA627@thunk.org>
	<CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
	<20180813173502.1a7a1d9c@alans-desktop>
	<CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
	<20180813172947.GS6515@ZenIV.linux.org.uk>
	<alpine.LRH.2.21.1808140458040.23296@namei.org>
Message-ID: <48e443ba-51b5-cf10-3342-cdeabb91b224@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/13/2018 12:00 PM, James Morris wrote:
> On Mon, 13 Aug 2018, Al Viro wrote:
>
>> On Mon, Aug 13, 2018 at 09:48:53AM -0700, Andy Lutomirski wrote:
>>> Are there cases I'm missing?  It sounds like the API could be improved
>>> to fully model the last case, and everything will work nicely.
>> 	You know, that's starting to remind of this little gem of Borges:
>> http://www.alamut.com/subj/artiface/language/johnWilkins.html
>> Especially the delightful (fake) quote contained in there:
>> [...] it is written that the animals are divided into:
>> 	(a) belonging to the emperor,
>> 	(b) embalmed,
>> 	(c) tame,
>> 	(d) sucking pigs,
>> 	(e) sirens,
>> 	(f) fabulous,
>> 	(g) stray dogs,
>> 	(h) included in the present classification,
>> 	(i) frenzied,
>> 	(j) innumerable,
>> 	(k) drawn with a very fine camelhair brush,
>> 	(l) et cetera,
>> 	(m) having just broken the water pitcher,
>> 	(n) that from a long way off look like flies.
>
> Coincidentally, this was also the model for Linux capabilities.

Linux capabilities are POSIX capabilities which are modeled closely
to accommodate the historical behavior manifest in the P1003.1 specification.
So except for (c), (f) and (k) you can use this characterization. 

On a slightly more serious note, there's a lot of Linux, mount semantics
included, that have grow organically and that aren't quite up to the
usage models they are being applied to. I applaud David's work in part
because it may make it possible to accommodate more of those cases going
forward.
