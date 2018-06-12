From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 12 Jun 2018 17:36:01 -0400
Subject: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
	<fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
	<alpine.LRH.2.21.1806130631400.13763@namei.org>
	<CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
	<9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
Message-ID: <1528839361.3874.10.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-12 at 14:29 -0700, John Johansen wrote:
> On 06/12/2018 02:12 PM, Paul Moore wrote:
> > On Tue, Jun 12, 2018 at 4:32 PM, James Morris <jmorris@namei.org> wrote:
> >> On Mon, 11 Jun 2018, Casey Schaufler wrote:
> >>
> >>> If you want to break this up by security module I would take
> >>> the Smack part as soon as James does the tree update. If James
> >>> wants to take the whole thing at once you can add my:
> >>>
> >>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>
> >>> for the Smack changes.
> >>
> >> It's probably simplest for me to take them as one patch.
> > 
> > I would prefer if the SELinux changes were split into a separate
> > patch.  I'm guessing John would probably want the same for the
> > AppArmor patches, but take his work for it, not mine.
> 
> yes that would be preferred

Agreed
> 
> > 
> > Joe, in general I really appreciate the fixes you send, but these
> > patches that cross a lot of subsystem boundaries (this isn't the first
> > one that does this) causes unnecessary conflicts in -next and during
> > the merge window.  Could you split your patches up from now on please?
> > 
> 
> yeah splitting patches at subsystem boundaries is highly recommended.

Agreed

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
