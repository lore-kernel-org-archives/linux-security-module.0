Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCE17B4FA
	for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543771; cv=none; b=MOdB93SMBipTR69SCm8nGfN/kNCiTR9yyhjLIPCxBMUypkMqj89KVTGviQE9GQhSJ60e1q0Txdt1C+ySib3sEdr6Da7cU1CzJE1D4hZge+hjVgDZLvLFfHe/KS/IwaH+8Q5zmYZlDo+UlWJQwI589XeFscqlIvGHXlU5EvOU5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543771; c=relaxed/simple;
	bh=JtIGOIfEY2J5+HBYsOLJeZbv7srucT4gvTbpsHqH1js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLgOg8W0jmkVy1kE7/E6sOhzn+O9ybWhIyUfx/jvFqkZku++2IxkZb8ANgFM6ZHMl561nJKBVTkCb8HICkkiZ+qJ20KSm5P20kANmIWB8Z541Oi3WDjpiIsPqI+dKopJ9WknYTEk7i8dX9N+Au51Ck8NNX5t52b+G8pGHLtGkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qsAGM+/0; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qsAGM+/0"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WjnDP3HxZzHlD;
	Tue, 13 Aug 2024 12:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723543765;
	bh=BvkxhLSfP0GLpl/b5SaDUQzyCrdpCwqRP9YOE3sw4cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsAGM+/0bA96YKHhFPmDzMqqJdgNJHZB4TyLk1rnFwJNOAEpwAAi4fNU5HddTwIMW
	 SDzuGAwoD/NPuRzOzgO2KcBCCBQZ6SJFTJYdynTsWi2PdRYTFgiZqpcogwCrSAE74O
	 6i2zNmfoyAF12QwGuM9cLfrfVqnaniWVILgpJ7Kc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WjnDN6HWTzDXr;
	Tue, 13 Aug 2024 12:09:24 +0200 (CEST)
Date: Tue, 13 Aug 2024 12:09:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook
 inconsistencies
Message-ID: <20240813.iidaejohj5Oo@digikod.net>
References: <20240812174421.1636724-1-mic@digikod.net>
 <o6ptrfa7gjdukphqtp6dakq3ykndrjusuhi4fyvpc5ne6amcig@lqbdb2dg7yzv>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o6ptrfa7gjdukphqtp6dakq3ykndrjusuhi4fyvpc5ne6amcig@lqbdb2dg7yzv>
X-Infomaniak-Routing: alpha

On Mon, Aug 12, 2024 at 11:45:29PM +0200, Mateusz Guzik wrote:
> On Mon, Aug 12, 2024 at 07:44:17PM +0200, Mickaël Salaün wrote:
> 
> No opinion about the core idea, I'll note though that this conflicts
> with a patch to move f_owner out of the struct:
> https://lore.kernel.org/linux-fsdevel/20240809-koriander-biobauer-6237cbc106f3@brauner/

Thanks for the heads-up.

> 
> Presumably nothing which can't get sorted out with some shoveling.
> 
> I do have actionable remark concerning creds though: both get_cred and
> put_cred are slow. Sorting that out is on my todo list.
> 
> In the meantime adding more calls can be avoided:

OK, I'll add that in the next version.

> 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 4f03beed4737..d28b76aef4f3 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -66,6 +66,7 @@ static inline void file_free(struct file *f)
> >  	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
> >  		percpu_counter_dec(&nr_files);
> >  	put_cred(f->f_cred);
> > +	put_cred(f->f_owner.cred);
> 
> 	if (likely(f->f_cred == f->f_owner.cred)) {
> 		put_cred_many(f->f_cred, 2);
> 	} else {
> 		put_cred(f->f_cred);
> 		put_cred(f->f_owner.cred);
> 	}
> 
> >  	if (unlikely(f->f_mode & FMODE_BACKING)) {
> >  		path_put(backing_file_user_path(f));
> >  		kfree(backing_file(f));
> > @@ -149,9 +150,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
> >  	int error;
> >  
> >  	f->f_cred = get_cred(cred);
> > +	f->f_owner.cred = get_cred(cred);
> 
> 	f->f_cred = f->f_owner.cred = get_cred_many(cred, 2);
> 
> >  	error = security_file_alloc(f);
> >  	if (unlikely(error)) {
> >  		put_cred(f->f_cred);
> > +		put_cred(f->f_owner.cred);
> 
> 		put_cred_many(cred, 2);
> 
> >  		return error;
> >  	}
> 
