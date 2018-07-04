From: paul@paul-moore.com (Paul Moore)
Date: Wed, 4 Jul 2018 08:36:12 -0400
Subject: [RFC PATCH v2] ipv6: make ipv6_renew_options() interrupt/kernel
	safe
In-Reply-To: <20180704.142853.1524154785411171806.davem@davemloft.net>
References: <153055565291.30739.11949388336400371265.stgit@chester>
	<20180704.142853.1524154785411171806.davem@davemloft.net>
Message-ID: <CAHC9VhR4L5_zMyMsNqS2820rjGLOqEQR6mc2cHaR-Qmhbg-yQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 4, 2018 at 1:29 AM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <pmoore@redhat.com>
> Date: Mon, 02 Jul 2018 14:20:52 -0400
>
> > -static int ipv6_renew_option(void *ohdr,
> > -                          struct ipv6_opt_hdr __user *newopt, int newoptlen,
> > -                          int inherit,
> > -                          struct ipv6_opt_hdr **hdr,
> > -                          char **p)
> > +static void ipv6_renew_option(int renewtype,
> > +                           struct ipv6_opt_hdr **dest,
> > +                           struct ipv6_opt_hdr *old,
> > +                           struct ipv6_opt_hdr *new,
> > +                           int newtype, char **p)
> >  {
>  ...
> > +     p += CMSG_ALIGN(ipv6_optlen(*dest));
>
> I don't think this actually advances the pointer in the caller,
> you need something like:
>
>         *p += CMSG_ALIGN(ipv6_optlen(*dest));

Yep, my mistake (typo); thanks for catching it.  Rebuilding a test
kernel now ...

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
