From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 05 Feb 2018 10:36:42 -0500
Subject: [RFC PATCH] ima: force the re-evaluation of files on untrusted
	file systems
In-Reply-To: <CADZs7q7oyC3LPmCFDTK9a7rdpXAAS=kT5HSURcN3t3oirvBpmg@mail.gmail.com>
References: <1517838054.3736.49.camel@linux.vnet.ibm.com>
	<CADZs7q7oyC3LPmCFDTK9a7rdpXAAS=kT5HSURcN3t3oirvBpmg@mail.gmail.com>
Message-ID: <1517845002.3736.72.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-02-05 at 15:24 +0100, Alban Crequy wrote:
> On Mon, Feb 5, 2018 at 2:40 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On filesystems, such as fuse or remote filesystems, that we can not
> > detect or rely on the filesystem to tell us when a file has changed,
> > always re-measure, re-appraise, and/or re-audit the file.
> >
> > Signed-of-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >
> > ---
> > Hi Miklos,
> >
> > Was something like this what you had in mind?
> >
> > Mimi
> > ---
> >  security/integrity/ima/ima_main.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 6d78cb26784d..a428bd75232e 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -170,6 +170,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >                                int mask, enum ima_hooks func, int opened)
> >  {
> >         struct inode *inode = file_inode(file);
> > +       struct dentry *dentry = file_dentry(file);
> >         struct integrity_iint_cache *iint = NULL;
> >         struct ima_template_desc *template_desc;
> >         char *pathbuf = NULL;
> > @@ -228,9 +229,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >                                  IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
> >                                  IMA_ACTION_FLAGS);
> >
> > -       if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
> > -               /* reset all flags if ima_inode_setxattr was called */
> > +       /*
> > +        * Re-measure, re-appraise, and/or re-audit a file, if the security
> > +        * xattrs changed or if the file is on an untrusted file system
> > +        * (eg. FUSE, remote filesystems).
> > +        */
> > +       if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
> > +           (dentry->d_op && dentry->d_op->d_revalidate)) {
> 
> It seems dangerous to rely implicitly on "d_revalidate != NULL". vfat
> has a d_revalidate for handling 8.3 filenames but it's not a network
> filesystem.

Files might be unnecessarily re-evaluated, impacting performance, but
I'm not sure that it is dangerous. ?For example, local OCFS2 files are
unnecessarily re-evaluated.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
