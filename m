From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 22 Aug 2017 08:54:25 -0400
Subject: [PATCH v6 3/6] ima: always measure and audit files in policy
In-Reply-To: <CACE9dm_xVdJU8+7GfB_0mtjD1jH+cxMq5JstM1_TkYaZU02JGw@mail.gmail.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-4-git-send-email-zohar@linux.vnet.ibm.com>
	<CACE9dm_xVdJU8+7GfB_0mtjD1jH+cxMq5JstM1_TkYaZU02JGw@mail.gmail.com>
Message-ID: <1503406465.8360.52.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-08-22 at 13:05 +0300, Dmitry Kasatkin wrote:
> On Tue, Aug 15, 2017 at 5:43 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > All files matching a "measure" rule must be included in the IMA
> > measurement list, even when the file hash cannot be calculated.
> > Similarly, all files matching an "audit" rule must be audited, even when
> > the file hash can not be calculated.
> >
> > The file data hash field contained in the IMA measurement list template
> > data will contain 0's instead of the actual file hash digest.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >
> > ---
> > Changelog v6:
> > - replace "?:" with if/then
> > - annotate i_version usage
> > - reword O_DIRECT comment
> >
> > Changelog v5:
> > - Fail files opened O_DIRECT, but include attempt in measurement list.
> >
> > Changelog v4:
> > - Based on both -EBADF and -EINVAL
> > - clean up ima_collect_measurement()
> >
> >  security/integrity/ima/ima_api.c    | 67 +++++++++++++++++++++++--------------
> >  security/integrity/ima/ima_crypto.c | 10 ++++++
> >  security/integrity/ima/ima_main.c   |  7 ++--
> >  3 files changed, 54 insertions(+), 30 deletions(-)
> >
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index c2edba8de35e..1dee695642a4 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -199,42 +199,59 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
> >         struct inode *inode = file_inode(file);
> >         const char *filename = file->f_path.dentry->d_name.name;
> >         int result = 0;
> > +       int length;
> > +       void *tmpbuf;
> > +       u64 i_version;
> >         struct {
> >                 struct ima_digest_data hdr;
> >                 char digest[IMA_MAX_DIGEST_SIZE];
> >         } hash;
> >
> > -       if (!(iint->flags & IMA_COLLECTED)) {
> > -               u64 i_version = file_inode(file)->i_version;
> > +       if (iint->flags & IMA_COLLECTED)
> > +               goto out;
> >
> > -               if (file->f_flags & O_DIRECT) {
> > -                       audit_cause = "failed(directio)";
> > -                       result = -EACCES;
> > -                       goto out;
> > -               }
> > +       /*
> > +        * Dectecting file change is based on i_version. On filesystems
> > +        * which do not support i_version, support is limited to an initial
> > +        * measurement/appraisal/audit.
> > +        */
> > +       i_version = file_inode(file)->i_version;
> > +       hash.hdr.algo = algo;
> >
> > -               hash.hdr.algo = algo;
> > -
> > -               result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
> > -                       ima_calc_buffer_hash(buf, size, &hash.hdr);
> > -               if (!result) {
> > -                       int length = sizeof(hash.hdr) + hash.hdr.length;
> > -                       void *tmpbuf = krealloc(iint->ima_hash, length,
> > -                                               GFP_NOFS);
> > -                       if (tmpbuf) {
> > -                               iint->ima_hash = tmpbuf;
> > -                               memcpy(iint->ima_hash, &hash, length);
> > -                               iint->version = i_version;
> > -                               iint->flags |= IMA_COLLECTED;
> > -                       } else
> > -                               result = -ENOMEM;
> > -               }
> > +       /* Initialize hash digest to 0's in case of failure */
> > +       memset(&hash.digest, 0, sizeof(hash.digest));
> > +
> > +       if (buf)
> > +               result = ima_calc_buffer_hash(buf, size, &hash.hdr);
> > +       else
> > +               result = ima_calc_file_hash(file, &hash.hdr);
> > +
> > +       if (result && result != -EBADF && result != -EINVAL)
> > +               goto out;
> > +
> > +       length = sizeof(hash.hdr) + hash.hdr.length;
> > +       tmpbuf = krealloc(iint->ima_hash, length, GFP_NOFS);
> > +       if (!tmpbuf) {
> > +               result = -ENOMEM;
> > +               goto out;
> >         }
> > +
> > +       iint->ima_hash = tmpbuf;
> > +       memcpy(iint->ima_hash, &hash, length);
> > +       iint->version = i_version;
> > +
> > +       /* Possibly temporary failure due to type of read (eg. O_DIRECT) */
> > +       if (result != -EBADF && result != -EINVAL)
> > +               iint->flags |= IMA_COLLECTED;
> 
> 
> Result can be other than 0, EBADF and EINVAL here?
> It is confusing.. simpler than can be just
> 
> if (!result)
>  iint->flags |= IMA_COLLECTED;
> 
> Isn't it?

Yes, that is better.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
