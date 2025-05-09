Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CF64A8F;
	Fri,  9 May 2025 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761020; cv=none; b=Fax/VjoYI1FX3BiByxQTlGoiMIEFESendrNVNzKhXNGorazvHJ6CnQIK3dFoPz9te6+3uSAzQzD+V/ddg/xTI6jBReo09/5wcVcyVgwbanm+CrDjj3zt3GCeV24kCLw3912P3xL1vy5RplZum/3cgbGI0Ydh57BF+Rti+tV0sg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761020; c=relaxed/simple;
	bh=aq59dRcFi8HDohmDuQ/0lA/OfRUS3wr+VrtOYgXpwac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRrnoFZ84+IDzDqFbtgcfDjAOl1iSQHBspVfvRUUjrygmjsCPl3AtGi1XH4JeCT9/v8jt4YIbYPLGV+tk0LfqISqCtijFx1kc4Gi69gt0rwUzv1b0GkHdJWq/QFcsSZn1GFBQne/fRC0ZpzAMcxrX5EaNCG9dfcTe0sks/kUt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BT0nKIYt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BT0nKIYt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6twfXBtE2DEQcWdr1sjZzN400y+anVUxZjhsMnkK8m8=; b=BT0nKIYthAnpX9O9nftx/502uV
	L4OY6zkOc1BlTiJX9W1xWQkbCAb0dE3iKZn9ECLbfaFRo6JsqTxx3YCgXIpo/+3quGGEdTQ3SBuO1
	eAnNZzxAuZMiGgyppSo9Eq8vh85aVpqQH2jPMZoilH//U+kdDarZL7Kq3eCft9NTlGWqWA+CgDq5s
	41ji9MhQDhT02dpVsal69HtRzt+1DRx/RODKXo/1KWZamG5++qzjylfakIri33iypeW8x7pVeTEHZ
	G/YIizZjD+1crKCgAX9WJiEU/W5k4Tzbu80MYq/gaXEWtKgIdn8dn1oEjDqW/oP1hCDK8vyu33IXx
	sLhEuexA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDEKc-00000009on1-2qa1;
	Fri, 09 May 2025 03:23:26 +0000
Date: Fri, 9 May 2025 04:23:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in
 securityfs_remove()
Message-ID: <20250509032326.GJ2023217@ZenIV>
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140438.648533-2-alexjlzheng@tencent.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 08, 2025 at 10:04:39PM +0800, alexjlzheng@gmail.com wrote:

> In addition, securityfs_recursive_remove() avoids this problem by calling
> __d_drop() directly. As a non-recursive version, it is somewhat strange
> that securityfs_remove() does not clean up the deleted dentry.
> 
> Fix this by adding d_delete() in securityfs_remove().

This is not a fix.  First and foremost, securityfs_recursive_remove()
does *not* just call __d_drop() - it calls simple_recursive_removal(),
which takes care to evict anything possibly mounted on those suckers.

Your variant trivially turns into a mount leak - just bind anything
on that thing and trigger removal.

<a bit of a rant follows; if it offends somebody, feel free to report
to CoC committee>

What's more, securityfs object creation is... special.  It does, for
some odd reason, leave you dentry with refcount *two*.  For no reason
whatsoever, as far as I can tell.

securityfs_remove() matches that; securityfs_recursive_remove(),
as far as I can tell, should simply leak them.  That's from RTFS
alone, but I don't see how it could possibly *not* happen -
securityfs_create_file() is a call of securityfs_create_dentry(),
which
	* calls lookup_one_len(), getting a negative dentry with
refcount 1.
	* verifies it's negative
	* gets a new inode
	* does d_instantiate(), attaching it to dentry.
	* does dget(), for some unspeakable reason.  Refcount is 2 now.
	* returns that dentry to caller.

policyfs stuff calls securityfs_create_dir() (which is a wrapper for
securityfs_create_file(), with nothing extra done to refcounts),
then populates it with a bunch of files, all with the same refcount
weirdness.

Result: directory dentry with refcount 2 + number of children and
a bunch of children, each with refcount 2.

Now, securityfs_recursive_remove() calls simple_recursive_removal(),
which will strip _one_ off the refcount of each dentry in that tree.
Yes, they are all unhashed and any stuff mounted on them is kicked
out, but you have a massive dentry leak now - all of those dentries
have refcount at least 1.

I'm not blaming securityfs_recursive_remove() authors - it *should*
have worked; their only fault is that they hadn't guessed that
object creation on securityfs happens to be that strange.

Another special snowflake is efi_secret_unlink() - it calls
securityfs_remove(), which is needed instead of simple_unlink()
since
	* that double refcount needs to be dropped
	* having internal mount pinned is something that needs
to be undone, innit?

Of course, it runs afoul of the parent being locked, but nevermind that -
it just unlocks and relocks it, 'cuz what can go wrong?  That - instead
of discussing that with VFS and filesystem folks.

As for "what can go wrong"...  Consider what happens if another process
calls unlink() on the same file, just before the first one drops the
lock on parent.  Parent found, process 2 blocked on the lock.  Process 1
unlocks that lock and loses CPU.  Process 2 runs and tries to lock the
victim; blocks since process 1 is still holding it locked.  Process 1,
in securityfs_remove(): blocks trying to lock the parent.  AB-BA deadlock.

Oh, well...

Anyway, the reasons for securityfs_remove() use there are real deficiencies
of securityfs.  Weird shit with refcounts is one thing; internal mount
pinning is a bit more subtle, but it's also solvable.

The thing is, objects on securityfs never change parents.  So you only
need to pin for subdirectories of root - everything deeper will be
automatically fine.  And that kills the second reason for those games.
With that dealt with, efi_secret_unlink() can simply call simple_unlink()
instead of those games.

After that securityfs_remove() can become an alias for
securityfs_recursive_remove() (or the other way round, preferably).

BTW,
        d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
in the same drivers/virt/coco is also nasty - you don't change the method
table on an object that is already exposed in shared data structures.
Basic multithreaded programming safety rules...  Yes, _that_ probably runs
too early in the boot for anything to hit it, so it's not a security hole,
but the same "what if somebody copies that code and gets screwed" applies
there...  If anything, that points to the need of securityfs_create_dir()
variant that would override ->i_op, which should've been discussed back
when the thing had been merged.

</rant>

I have fixes for some of that crap done on top of tree-in-dcache series;
give me an hour or two and I'll separate those and rebase to mainline...
