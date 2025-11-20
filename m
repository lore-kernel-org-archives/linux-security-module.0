Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B01357A42
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652451; cv=none; b=hAjWMuOk4VxIf81va5NR+pgnNjUJ8QntSS8XgMP9DHtRxzJoaaDgbcur3I/8khuEfPZuAIxMt/EzNLWWRBqo44g+UDq6ay5Xs19En4GLE/ELHrlD9+Qtkaw4hjsMHZZ84RgzZcsmCgcxlMLhfKXg8QD4VRqnpMOwE8yl55VbUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652451; c=relaxed/simple;
	bh=iIk2BlOApNYSVmrs+9BCW2HCqwwttuI8ihELG3476CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU11qiVTaFfy4a6/Oza+ooG2qUaSYTITaku1M+0UDh2W4VcWo6zadOiBIZ9KPETYXDkQskd08w7mRUPh9Ol7VR14QQc0bQQ3Wt/NUZQ966vop1c1S07GuP9n7KGpIO97BT7pl9r+klf+nbpq+mmFGDRZ+Ja7iwrY979ZtC5GJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P3yPidBY; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P3yPidBY"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dC1SQ1NZKzgY8;
	Thu, 20 Nov 2025 15:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1763650117;
	bh=/i1+4uOLqc/XPmv4qXTLEdok4sSWtH4t65ILmZFTBsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3yPidBYFx4hxBgulYeoDMGSPWmW2pudiOFAr2w6aazXD36NDs89k1qXuXXTx3KLg
	 uJ8+DzWzaxa4rcoQLsOqGaWFlofDDjsoKMRCf5PW/JNDNkvgr/tL6NIgnkgbyKcLyz
	 Lrdy7jkSCB5PS4vZOQcGL5XvLYXfyyR8VXHVk3K0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dC1SK3RbmzQXW;
	Thu, 20 Nov 2025 15:48:33 +0100 (CET)
Date: Thu, 20 Nov 2025 15:48:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?B?6K645L2z5Yev?= <xujiakai24@mails.ucas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [BUG] landlock: sleeping function called from invalid context in
 hook_sb_delete()
Message-ID: <20251120.hoT5ye5thooR@digikod.net>
References: <20dd8187.9d18.19a75eadc43.Coremail.xujiakai24@mails.ucas.ac.cn>
 <20251120.c5c17c664315@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120.c5c17c664315@gnoack.org>
X-Infomaniak-Routing: alpha

Thanks for the report.

This was indeed a false positive.  The fix (previously reported by
syzkaller) is merged in -next and soon in the master branche:
https://lore.kernel.org/r/20251105212025.807549-1-mjguzik@gmail.com


On Thu, Nov 20, 2025 at 09:48:43AM +0100, Günther Noack wrote:
> Hello!
> 
> Thanks for the report!
> 
> CC-ing Mickaël, who authored that code
> 
> On Wed, Nov 12, 2025 at 10:35:17AM +0800, 许佳凯 wrote:
> > The call trace indicates that hook_sb_delete() holds s_inode_list_lock (a spinlock) while invoking operations that may eventually call iput(), which can sleep.
> > This violates the locking context expectations and triggers __might_sleep() warnings.
> > The issue seems to be related to how Landlock handles superblock cleanup during security_sb_delete().
> > 
> > 
> > I’m currently only reporting this issue to the community; the exact fix will likely need to be confirmed and implemented by the Landlock and filesystem maintainers.
> 
> This looks like a false positive to me.
> 
> There are three places where iput() is being called in hook_sb_delete,
> two of them are in places where it is *not* holding the
> s_inode_list_lock.  The one that *is* holding the s_inode_list_lock
> has the following comment:
> 
> /*
>  * At this point, we own the ihold() reference that was
>  * originally set up by get_inode_object() and the
>  * __iget() reference that we just set in this loop
>  * walk.  Therefore the following call to iput() will
>  * not sleep nor drop the inode because there is now at
>  * least two references to it.
>  */
> 
> That seems to indicate that the sleepability concern was taken into
> consideration.  iput() only sleeps if the refcount reaches zero, and
> if you can exclude that, it won't sleep.
> 
> —Günther
> 
> -- 
> 
