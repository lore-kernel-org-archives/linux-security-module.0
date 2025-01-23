Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D512FB1B
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664475; cv=none; b=oUC8fGLFS7Es7PlpcZTzsrrwBvWW0I+NUB94qpCmJzyQycUK72izUoV8t9JwHbb9U+o0xMNHcekmqce0NoyZCSpPAWt0O1AwIdaAK3/yVJvHXlXjldRLUdIctQtCH6whADte449fNPLgfBeHRNdlZYBzbb1oFGpqJnR0RpurA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664475; c=relaxed/simple;
	bh=ZR6cIOcTfj2fYB8OdhyRkKnDmT0c7vZ8O9YmtjYS6sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvXGOiwAT+MweqRSTWLPYVeOnDq07alwZtWUY8zAIdie/D9lk1IJx2aglFEoLKmvFOrsMG598LB69BWI0pwaqrX2wqpvT+KKF+BTb0B5OaS+MKe28/xGO7z0F4vgUdIhX5ycJSjItjpBrF4XGGLthqdOXSLmhZsSddEmQKfl2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=z9iaQmjG; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="z9iaQmjG"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YfCNG1WByzg0n;
	Thu, 23 Jan 2025 21:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737664462;
	bh=irHmoTCn7ZZDF3mJgq/Ca/BObYs/zn0JHfu1uLiu7wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z9iaQmjGwfkq1N87MaUIbxDWRXGAcypwSwl8KA9RTLVbtsEv6EYtLz19bKHKKMm/K
	 etkV8sEJfMQNGi7OCHmHvg1jICcp/qMYjCP/+1pikzmPM5ADurHnzz2KKJRaCxJC9h
	 PdEvRGmv+6zQm6q3CdkAukXxRAnY7lu7Y/IZY4ik=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YfCNF0NK6zqhY;
	Thu, 23 Jan 2025 21:34:20 +0100 (CET)
Date: Thu, 23 Jan 2025 21:34:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Shervin Oloumi <enlightened@chromium.org>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, gnoack@google.com, 
	shuah@kernel.org, jorgelo@chromium.org, allenwebb@chromium.org
Subject: Re: [PATCH v3 1/2] fs: add loopback/bind mount specific security hook
Message-ID: <20250123.So6iudahtoom@digikod.net>
References: <20250110021008.2704246-1-enlightened@chromium.org>
 <CAMb9sTgEjNk4X+FLwpmi56z+LDV=gYOO=qN5AjQSN4Erw-SUaw@mail.gmail.com>
 <20250110-luftverkehr-lagen-e9c26ffc277f@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110-luftverkehr-lagen-e9c26ffc277f@brauner>
X-Infomaniak-Routing: alpha

On Fri, Jan 10, 2025 at 04:42:19PM +0100, Christian Brauner wrote:

> On Thu, Jan 09, 2025 at 08:14:07PM -0800, Shervin Oloumi wrote:
> > On Fri, Jan 3, 2025 at 3:11 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 30-12-24 17:46:31, Shervin Oloumi wrote:

> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index 23e81c2a1e3f..c902608c9759 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
> > > >       if (err)
> > > >               return err;
> > > >
> > > > +     err = security_sb_bindmount(&old_path, path);
> > > > +     if (err)
> > > > +             goto out;
> > > > +
> > >
> > > So this gets triggered for the legacy mount API path (mount(2) syscall).
> > > For the new mount API, I can see open_tree() does not have any security
> > > hook. Is that intented? Are you catching equivalent changes done through
> > > the new mount API inside security_move_mount() hook?
> > 
> > I am not very familiar with the new API and when it is used, but LandLock does
> > listen to security_move_mount() and it rejects all such requests. It also
> > listens to and rejects remount and pivotroot. Are there cases where bind mount
> > requests go through open_tree() and this hook is bypassed?
> 
> Whether or not Landlock currently blocks security_move_mount()
> unconditionally doesn't matter. Introducing this api will have to do it
> for the old and the new mount api. First, because we don't implement new
> features for the old mount api that aren't also available in the new
> mount api. Second, because this asymmetry just begs for bugs when
> security_move_mount() isn't blocked anymore.
> 
> And third, there seems to be a misconception here.
> open_tree(OPEN_TREE_CLONE) gives you an unattached bind-mount.
> move_mount() is just sugar on top to attach it to a mount namespace.
> 
> But a file descriptor from open_tree(OPEN_TREE_CLONE) can be interacted
> with just fine, i.e., read, write, create, shared with other processes.
> You could create a bind-mount that is never attached anywhere. So I'm
> not sure what security guarantees it would give you to block MS_BIND but
> not OPEN_TREE_CLONE.
> 
> It should be done for both.

Yes, the new hook should probably be called by attach_recursive_mnt().

Landlock tests should check with the legacy mount(2) and the new
move_mount(2) (e.g. with test variants).

> 
> > 
> > > Also what caught my eye is that the LSM doesn't care at all whether this is
> > > a recursive bind mount (copying all mounts beneath the specified one) or
> > > just a normal one (copying only a single mount). Maybe that's fine but it
> > > seems a bit counter-intuitive to me as AFAIU it implicitly places a
> > > requirement on the policy that if doing some bind mount is forbidden, then
> > > doing bind mount of any predecessor must be forbidden as well (otherwise
> > > the policy will be inconsistent).
> > 
> > I need to double check this with Mickaël, but I think it is safe to allow
> > recursive bind mounts. If a bind mount was allowed, let's say /A -> /home/B,
> > then we already verified that the process did not gain more access (or even
> > dropped some access) through the new mount point, e.g. accessing /A/a through
> > /home/B/a. So with a recursive bind mount, let's say /home -> /C, once we check
> > for privilege escalation as usual, it should be safe to clone any existing sub
> > mounts in the new destination. Because if access through B <= A and C <= B then
> > access through C <= A. So back to your point, there should never exist an
> > illegal bind mount action that can implicitly happen through a legal recursive
> > bind mount of its predecessor. Regardless, I think it might be useful to know if
> > a mount is recursive for other use cases so I added a boolean for surfacing
> > MS_REC in the new patches.
> 
> Say /home/hidden is covered by a bind-mount of /dev/null and you're
> doing mount --bind /home /somewhere then /home/hidden will be uncovered
> (There's cases where the kernel itself fuses mounts together or "locks"
> them so things like this cannot happen e.g., when creating an
> unprivileged mount namespace.). If your policy blocks unmounting
> /home/hidden to protect the underlying file then a non-recursive
> bind-mount would be able to circumvent that restriction.

That would be a valid attack scenario.  For Landlock, to make it simple,
non-recursive bind mounts should always be denied.

Shervin, please add this scenario in a comment for the Landlock
implementation of the hook.
