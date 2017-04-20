From: ben@decadent.org.uk (Ben Hutchings)
Date: Thu, 20 Apr 2017 16:02:23 +0100
Subject: [kernel-hardening] Re: [PATCH v3 1/2] modules:capabilities:
	automatic module loading restriction
In-Reply-To: <CAEiveUdS=GbyxDVeNFrjTmhvQB-a6UgrJXcGY=BYJLu+3z0x_Q@mail.gmail.com>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-2-git-send-email-tixxdz@gmail.com>
	<1492654942.31767.21.camel@decadent.org.uk>
	<CAEiveUdS=GbyxDVeNFrjTmhvQB-a6UgrJXcGY=BYJLu+3z0x_Q@mail.gmail.com>
Message-ID: <1492700543.31767.23.camel@decadent.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-04-20 at 14:44 +0200, Djalal Harouni wrote:
> > On Thu, Apr 20, 2017 at 4:22 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> > On Thu, 2017-04-20 at 00:20 +0200, Djalal Harouni wrote:
> > [...]
> > > +modules_autoload:
> > > +
> > > +A sysctl to control if modules auto-load feature is allowed or not.
> > > +This sysctl complements "modules_disabled" which is for all module
> > > +operations where this flag applies only to automatic module loading.
> > > +Automatic module loading happens when programs request a kernel feature
> > > +that is implemented by an unloaded module, the kernel automatically
> > > +runs the program pointed by "modprobe" sysctl in order to load the
> > > +corresponding module.
> > > +
> > > +When modules_autoload is set to (0), the default, there are no
> > > +restrictions.
> > > +
> > > +When modules_autoload is set to (1), processes must have CAP_SYS_MODULE
> > > +to be able to trigger a module auto-load operation, or CAP_NET_ADMIN
> > > +for modules with a 'netdev-%s' alias.
> > > +
> > > +When modules_autoload is set to (2), automatic module loading is
> > > +disabled for all. Once set, this value can not be changed.
> > 
> > I would expect a parameter 'modules_autoload' to be a boolean, so this
> > behaviour would be surprising.
> > 
> > What is the point of mode 2???Why would someone want to set
> > modules_disabled=0 and modules_autoload=2?
> 
> modules_disabled is too restrictive and once set it can't be changed,
> maybe that's why not all users use it.
> 
> With modules_disabled=0 and modules_autoload=2
[...]

Hmm, OK.  How about naming this modules_autoload_mode, then, so that
it's obviously not a boolean?

Ben.

-- 
Ben Hutchings
It is easier to change the specification to fit the program than vice
versa.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170420/9bb425aa/attachment.sig>
