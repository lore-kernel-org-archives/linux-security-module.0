From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 13 Aug 2018 17:35:02 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
	<28045.1533916438@warthog.procyon.org.uk>
	<20180810161400.GA627@thunk.org>
	<CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
Message-ID: <20180813173502.1a7a1d9c@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> If the same block device is visible, with rw access, in two different
> containers, I don't see any anything good can happen.  Sure, with the

At the raw level there are lots of use cases involving high performance
data capture, media streaming and the like.

At the file system layer you can use GFS2 for example.

So there are cases where it's possible. There are even cases where it's
actually useful at the filesystem level although not many I agree.

Alan
