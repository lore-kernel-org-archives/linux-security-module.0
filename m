From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 14 Nov 2017 16:25:54 +0200
Subject: [PATCH] tpm: Update MAINTAINERS for Jason Gunthorpe
In-Reply-To: <E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
References: <20171031202357.GA1030@ziepe.ca>
	<20171103142841.2nphkjojzamrdezm@linux.intel.com>
	<0812DDC3-187D-4F29-BFB5-9A4F509CA376@gmx.de>
	<20171107150356.uln3lks64zt5oxjv@linux.intel.com>
	<20171108063640.kxwag6fzguetpjnf@linux.intel.com>
	<E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
Message-ID: <20171114142554.5lpzwrxemqachy7k@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 08, 2017 at 10:27:37AM +0100, Peter Huewe wrote:
> 
> 
> Am 8. November 2017 07:36:40 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
> >On Tue, Nov 07, 2017 at 05:03:56PM +0200, Jarkko Sakkinen wrote:
> >> On Fri, Nov 03, 2017 at 05:05:49PM +0100, Peter Huewe wrote:
> >> > 
> >> > 
> >> > Am 3. November 2017 15:28:41 MEZ schrieb Jarkko Sakkinen
> ><jarkko.sakkinen@linux.intel.com>:
> >> > >On Tue, Oct 31, 2017 at 02:23:57PM -0600, Jason Gunthorpe wrote:
> >> > >> My email address for open source work is moving to this new
> >permanent
> >> > >> personal address.
> >> > >> 
> >> > >> Signed-off-by: Jason Gunthorpe <jgunthorpe@ziepe.ca>
> >> > >> ---
> >> > >>  MAINTAINERS | 2 +-
> >> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > >> 
> >> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> > >> index 6671f375f7fcdd..b79eb071475ffc 100644
> >> > >> --- a/MAINTAINERS
> >> > >> +++ b/MAINTAINERS
> >> > >> @@ -13588,7 +13588,7 @@ TPM DEVICE DRIVER
> >> > >>  M:	Peter Huewe <peterhuewe@gmx.de>
> >> > >>  M:	Marcel Selhorst <tpmdd@selhorst.net>
> >> > >>  M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> > >> -R:	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >> > >> +R:	Jason Gunthorpe <jgg@ziepe.ca>
> >> > >>  W:	http://tpmdd.sourceforge.net
> >> > >>  L:	tpmdd-devel at lists.sourceforge.net (moderated for
> >non-subscribers)
> >> > >>  Q:	https://patchwork.kernel.org/project/tpmdd-devel/list/
> >> > >> -- 
> >> > >> 2.7.4
> >> > >> 
> >> > >
> >> > >Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> > >
> >> > >Should these updates go to my tree? I posted previous update to
> >> > >linux-kernel at vger.kernel.org.
> >> > Which equals /dev/null for most cases.
> >> > 
> >> > Why shouldn'tit go through your tree?
> >> > It's a maintainers update for your subsystem - and you did it in
> >the past when modifying the urls.
> >> > 
> >> > >/Jarkko
> >> > 
> >> > -- 
> >> > Sent from my mobile
> >> 
> >> I applied two patches to my tree.
> >> 
> >> /Jarkko
> >
> >NAK
> >
> NAK what?
> Who/what do you nak to?
> 
> >linux-kernel at vger.kernel.org is missing *completely*. It should be at
> >minimum in the CC field.
> >
> >My previous update did not go through my tree. I misread your original
> >response to say that I should put also URL update to my tree. I did.
> >It resulted a merge conflict.
> >
> I do not understand what you are saying.
> Please rephrase/clarify.
> 
> >Updating that file goes out of my territory other than acking the
> >updates. 
> Imho not really, since there is no MAINTAINERS maintainer.
> If you feel uncomfortable with adding the changes to MAINTAINERS via
> your tree, please ask James to pull them up - just as Mimi did for her
> linux-integrity update.

I'm just saying that the previous update did not go my tree but I can
queue this one to my tree given your comments. I just have to wait up
until the previous MAINTAINERS update is visible in the security
tree.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
