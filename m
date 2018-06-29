From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 28 Jun 2018 21:53:26 -0500
Subject: [PATCH] cap_inode_getsecurity: use d_find_any_alias() instead of
	d_find_alias()
In-Reply-To: <1530237431.30361.29.camel@mtkswgap22>
References: <1530082758.30361.7.camel@mtkswgap22>
	<20180628150152.GA10398@mail.hallyn.com>
	<CAOQ4uxjJJZ=J2oaiga8M6QSM3HCM6a1CP5zUv4uK5vODRJj2Vg@mail.gmail.com>
	<20180628172648.GA12196@mail.hallyn.com>
	<CAOQ4uxjOSTvEt5MBmZY7UqrsjuwGF9jKqK-v6YBFQwLt5wZuRg@mail.gmail.com>
	<20180628182850.GA12845@mail.hallyn.com>
	<1530237431.30361.29.camel@mtkswgap22>
Message-ID: <20180629025326.GA17892@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 29, 2018 at 09:57:11AM +0800, Eddie.Horng wrote:
> On Thu, 2018-06-28 at 13:28 -0500, Serge E. Hallyn wrote:
> > Ah - I just tried his reproducer, and in fact got:
> > 
> > 0 ? serge at sl ~/test $ getcap execveat
> > execveat = cap_sys_admin+ep
> > 0 ? serge at sl ~/test $ ./execveat
> > execveat: Bad file descriptor
> > 
> > on ext4, with 4.15.0-22-generic #24~16.04.1-Ubuntu
> > 
> > Without the filecap, it works.
> > 
> > -serge
> 
> The simple reproducer expected /bin/echo exists in the same 
> dir of execveat executable and does not check the return fd 
> of open("echo", ...). I'm not sure if you run into this case,
> but I tried to run execveat without echo exists, got same result:
> "execveat: Bad file descriptor".

Hah!  Yes, i was in too much of a hurry;  I ran it once with
./echo existing and no caps, that worked;  then i set the caps
on execveat instead of ./echo, and echo had gotten deleted by the
previous test causing the failure like you said.

So, the same thing does happen with setuid anyway, so while that
seems worth addressing one day,

Acked-by: Serge Hallyn <serge@hallyn.com>

thanks,
-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
