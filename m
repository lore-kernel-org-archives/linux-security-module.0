From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 19 May 2017 09:52:59 -0700
Subject: [PATCH] selinux: Mark array 'labeling_behaviors' as __maybe_unused
In-Reply-To: <1495208719.2209.12.camel@tycho.nsa.gov>
References: <20170518190759.28560-1-mka@chromium.org>
	<CAHC9VhSFrXLE349atrmFDYjCWuda_O4TtJgEUwnK-DDZUx00bw@mail.gmail.com>
	<1495208719.2209.12.camel@tycho.nsa.gov>
Message-ID: <20170519165259.GJ141096@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

El Fri, May 19, 2017 at 11:45:19AM -0400 Stephen Smalley ha dit:

> On Fri, 2017-05-19 at 11:09 -0400, Paul Moore wrote:
> > On Thu, May 18, 2017 at 3:07 PM, Matthias Kaehlcke <mka@chromium.org>
> > wrote:
> > > The array is only referenced in an ARRAY_SIZE() statement. Adding
> > > the
> > > attribute fixes the following warning when building with clang:
> > > 
> > > security/selinux/hooks.c:338:20: error: variable
> > > 'labeling_behaviors'
> > > ????is not needed and will not be emitted
> > > ????[-Werror,-Wunneeded-internal-declaration]
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > ?security/selinux/hooks.c | 2 +-
> > > ?1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > The fact that we only reference labeling_behaviors in one spot, and
> > even then we only use it as a parameter to ARRAY_SIZE(), makes me
> > believe we may be able to get rid of labeling_behaviors and use
> > SECURITY_FS_USE_MAX in its place.
> > 
> > Anyone working on any patches which make use of labeling_behaviors?
> 
> I think you could just remove both the array and the code that
> referenced it; it only made sense before commit
> 2088d60e3b2f53d0c9590a0202eeff85b288b1eb.  We already check that the
> policy doesn't contain any behavior > SECURITY_FS_USE_MAX during policy
> load, so this cannot occur (modulo memory corruption), and it was only
> there to make sure we didn't try to dereference off the end of the
> array prior to the aforementioned commit.

Thanks for your comments.

I will send out a patch that removes the array shortly.

Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
