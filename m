Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD783595C;
	Tue, 24 Jun 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798391; cv=none; b=AOYNUdBLzvKGY3cSfWYKqx+DZdYIAqLgSdip7CMoS6C+SCuis86f16KjzRiMs+vYiZ0Qp0WFqGkCpoIkqCQU3I96eY+CNqRNGQ7qTstZH9bWt4TgG+9b7J5YMmud56lhMgfkypox1e1vO2IXfH1LZ4rdYnpF3U2YIDVQ0VL9HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798391; c=relaxed/simple;
	bh=6jaG03zyu9kwTbu3ZXC3E5D6ygGmX9zCBHT5Fh2x/ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFBOvIufrTooZ+DMuvdbrRwaWsbD9i3V8twc1mAKbQRoNwEuXwvS6d/IvwTyOyy6rHwofEqXyuKwJ7kC/z67Uh62NFg1LOUt0naaJql3AO0r3m6yZuLTc8g14qp5agFJ/DpTOy5FTfJhDKf372V5bbxESg2LLM9vglfxAJFSA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 53C8547B; Tue, 24 Jun 2025 15:46:02 -0500 (CDT)
Date: Tue, 24 Jun 2025 15:46:02 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: sergeh@kernel.org, Yue Haibing <yuehaibing@huawei.com>,
	jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] security: Remove unused declaration cap_mmap_file()
Message-ID: <20250624204602.GA70964@mail.hallyn.com>
References: <20250624014108.3686460-1-yuehaibing@huawei.com>
 <aFqZxu_Slzmux6jj@lei>
 <CAHC9VhQ50UM6LxnUT7PSrGKNdbuUFJmZQmir1HtrQg_C9j6x2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ50UM6LxnUT7PSrGKNdbuUFJmZQmir1HtrQg_C9j6x2Q@mail.gmail.com>

On Tue, Jun 24, 2025 at 11:48:10AM -0400, Paul Moore wrote:
> On Tue, Jun 24, 2025 at 8:27 AM <sergeh@kernel.org> wrote:
> > On Tue, Jun 24, 2025 at 09:41:08AM +0800, Yue Haibing wrote:
> > > Commit 3f4f1f8a1ab7 ("capabilities: remove cap_mmap_file()")
> > > removed the implementation but leave declaration.
> > >
> > > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> >
> > Hm, how did I not catch that?  Thanks.
> 
> At least you weren't the idiot who wrote the original patch ;)
> 
> I'll grab this for the LSM tree in a bit unless you want to take it.

Either way - go ahead :)  Thanks.

> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > > ---
> > >  include/linux/security.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index dba349629229..e8d9f6069f0c 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -193,8 +193,6 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
> > >                         struct inode *inode, const char *name, void **buffer,
> > >                         bool alloc);
> > >  extern int cap_mmap_addr(unsigned long addr);
> > > -extern int cap_mmap_file(struct file *file, unsigned long reqprot,
> > > -                      unsigned long prot, unsigned long flags);
> > >  extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
> > >  extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> > >                         unsigned long arg4, unsigned long arg5);
> > > --
> > > 2.34.1
> 
> -- 
> paul-moore.com
