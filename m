From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 15 Aug 2018 09:51:36 -0700
Subject: Should we split the network filesystem setup into two phases?
In-Reply-To: <17763.1534350685@warthog.procyon.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<17763.1534350685@warthog.procyon.org.uk>
Message-ID: <DCE0E619-68F8-4906-8062-68D63DDED665@amacapital.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



> On Aug 15, 2018, at 9:31 AM, David Howells <dhowells@redhat.com> wrote:
> 
> Having just re-ported NFS on top of the new mount API stuff, I find that I
> don't really like the idea of superblocks being separated by communication
> parameters - especially when it might seem reasonable to be able to adjust
> those parameters.
> 
> Does it make sense to abstract out the remote peer and allow (a) that to be
> configured separately from any superblocks using it and (b) that to be used to
> create superblocks?
> 
> Note that what a 'remote peer' is would be different for different
> filesystems:

...

I think this looks rather nice.  But maybe you should generalize the concept of ?peer? so that it works for btrfs too. In the case where you mount two different subvolumes, you?re creating a *something*, and you?re then creating a filesystem that references it. It?s almost the same thing.

> 
> 


> 
>    fs = fsopen("nfs", 0);
>    fsconfig(fs, FSCONFIG_SET_PEER, "peer.1", NULL, peer1);

As you mention below, this seems like it might have namespacing issues.

>     

> In terms of alternative interfaces, I'm not sure how easy it would be to make
> it like cgroups where you go and create a dir in a special filesystem, say,
> "/sys/peers/nfs", because the peers records and names would have to be network
> namespaced.  Also, it might make it more difficult to use to create a root fs.
> 
> On the other hand, being able to adjust the peer configuration by:
> 
>    echo 71 >/sys/peers/nfs/server.home/timeo
> 
> does have a certain appeal.
> 
> Also, netlink might be the right option, but I'm not sure how you'd pin the
> resultant object whilst you make use of it.
> 

My suggestion would be to avoid giving these things names at all. I think that referring to them by fd should be sufficient, especially if you allow them to be reopened based on a mount that uses them and allow them to get bind-mounted somewhere a la namespaces to make them permanent if needed.

> A further thought is that is it worth making this idea more general and
> encompassing non-network devices also?  This would run into issues of some
> logical sources being visible across namespaces and but not others.

Indeed :)

It probably pays to rope a btrfs person into this discussion.
