Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F253D4137;
	Fri,  9 Oct 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553069; cv=none; b=YUQWyML1jidBYKkpajc4QShOy7rqE1RIlvf8jimOxAfBM4JgxvLDWGODvLbMbIVE7k/1Nwl62hXHJw9NgimonPAskxfeFKPXdLyGkW9VwjgUcgISt9uQEKkHWGhHubKYEgSlhsvM+Auq+/DMR2ahP05ojAe8uQ2qgdC+Jvbp6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553069; c=relaxed/simple;
	bh=5RUOn2j9ByX7mIyqkCskuAM0vt40AgTYwVMvNgKiwtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2NMTBHuUUYpt+eBe2ceq/QoXO16cFnbMWOasHXt5y1wER53Vw6D4svEQfb7nyu8yyShljtNtD5M0mNtkZ5FimUPSI5m5OnUYXipMWYTZO/INOE/jLPbFi/1m1Whv070wZjKs+RRdrxqesSSstkZmZdXssTXajbaeu1ZBvZGxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j1S4s3RhLz1HCSX;
	Fri,  9 Oct 2026 21:14:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5CA084055E;
	Fri,  9 Oct 2026 21:21:39 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwCXdy9a6shq3iC9AQ--.33096S2;
	Fri, 09 Oct 2026 14:21:38 +0100 (CET)
Message-ID: <2e59cc97ad2e6fe5b9b5a5b5988668da29155703.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: bound line scan in ima_read_policy() to fix OOB
 read
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Fabrice Derepas <fabrice.derepas@canonical.com>, Mimi Zohar
	 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
 <paul@paul-moore.com>,  James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 15:21:27 +0200
In-Reply-To: <1911937d73df65f70087c6f9b52798e1a5dfb33f.camel@huaweicloud.com>
References: <20260814085443.1211989-1-fabrice.derepas@canonical.com>
	 <1911937d73df65f70087c6f9b52798e1a5dfb33f.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCXdy9a6shq3iC9AQ--.33096S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWfJFy5Zry3Cr1rWw4xtFb_yoWxXw4xpF
	WvgFy5Ar1DXr17AFs293ZxXF1fK39rGF47G3yrX3W0v3ZxZr1Sg34UKFyS9F1SyryxXr1I
	vFZ0q39IkF1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGrIkbko8AAAsW

On Wed, 2026-08-26 at 11:51 +0200, Roberto Sassu wrote:
> On Fri, 2026-08-14 at 10:54 +0200, Fabrice Derepas wrote:
> > ima_read_policy() loads a policy file with kernel_read_file_from_path()
> > and splits it into lines with
> >=20
> > 	while (size > 0 && (p =3D strsep(&datap, "\n")))
> >=20
> > kernel_read_file() allocates the destination with vmalloc(i_size) --
> > exactly i_size bytes, and writes no NUL terminator. strsep()'s scan for
> > the next '\n' is not bounded by @size, so when the last line has no
> > trailing newline the scan runs off the end of the buffer (CWE-125). Whe=
n
> > i_size is a multiple of PAGE_SIZE the allocation has no slack and the
> > read walks into the vmalloc guard page and faults.
> >=20
> > Reproduced under KASAN in a VM: writing the path of a page-aligned
> > policy file with no trailing newline to <securityfs>/ima/policy oopses:
> >=20
> >   BUG: unable to handle page fault for address: ffffc90000032000
> >   #PF: supervisor read access in kernel mode
> >   RIP: 0010:strsep+0x7a/0xd0
> >   Call Trace:
> >    ima_write_policy+0x1f4/0x260
> >    vfs_write+0x16a/0x6f0
> >    ksys_write+0xcb/0x160
> >    do_syscall_64+0xe0/0x5a0
> >=20
> > This requires CAP_MAC_ADMIN (the policy file is mode 0200), but a polic=
y
> > file that does not end in a newline is an ordinary, non-malicious
> > condition, so a legitimate policy load can crash the kernel.
> >=20
> > Walk the buffer with memchr() bounded by the remaining size instead of
> > strsep(): terminate each line in place at its newline, and parse a
> > NUL-terminated copy of a final line that has none. The explicit per-lin=
e
> > accounting replaces the old "size -=3D rc" step, whose off-by-one
> > (ima_parse_add_rule() returns strlen() + 1) made a trailing line withou=
t a
> > newline fail with -EINVAL; such a policy now loads. The loop now consum=
es
> > the buffer exactly, so the trailing "if (size) return -EINVAL" is dropp=
ed.
>=20
> Looks unnecessarily complicated. I would replicate instead the same
> behavior of ima_write_policy() to allocate a buffer with an additional
> byte for the terminator.
>=20
> Read the inode size, vmalloc() size + 1, set the terminator, and pass
> the buffer to kernel_read_file_from_path().
>=20
> I would still pass NULL for file_size to save ourselves from rechecking
> if it changed after the kernel_read_file_from_path() call.

Could be simpler...

Something like this? (not tested)

diff --git a/security/integrity/ima/ima_fs.c
b/security/integrity/ima/ima_fs.c
index 3b8174a91a34..6151f440cd2f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -528,7 +528,7 @@ static const struct file_operations
ima_ascii_measurements_staged_ops =3D {
 static ssize_t ima_read_policy(char *path)
 {
 	void *data =3D NULL;
-	char *datap;
+	char *datap, *buf =3D NULL;
 	size_t size;
 	int rc, pathlen =3D strlen(path);
=20
@@ -548,6 +548,17 @@ static ssize_t ima_read_policy(char *path)
 	rc =3D 0;
=20
 	datap =3D data;
+	if (size && datap[size - 1] !=3D '\n') {
+		buf =3D kmemdup_nul(data, size, GFP_KERNEL);
+		if (!buf) {
+			vfree(data);
+			return -ENOMEM;
+		}
+		datap =3D buf;
+		/* Count the NUL terminator. */
+		size++;
+	}
+
 	while (size > 0 && (p =3D strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
 		rc =3D ima_parse_add_rule(p);
@@ -557,6 +568,7 @@ static ssize_t ima_read_policy(char *path)
 	}
=20
 	vfree(data);
+	kfree(buf);
 	if (rc < 0)
 		return rc;
 	else if (size)

Roberto

>=20
> Thanks
>=20
> Roberto
>=20
> > Fixes: 7429b092811f ("ima: load policy using path")
> > Assisted-by: copilot-cli:claude-opus-4-6 frama-c
> > Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> > ---
> > Tested under KASAN (CONFIG_KASAN_GENERIC + CONFIG_KASAN_VMALLOC) in QEM=
U,
> > loading a policy via "echo /path > <securityfs>/ima/policy":
> >=20
> >   - page-aligned file, no trailing newline: unpatched -> guard-page oop=
s
> >     in strsep()/ima_read_policy() (trace above); patched -> no fault, t=
he
> >     load fails cleanly with -EINVAL on the (garbage) content.
> >   - valid policy with a trailing newline: loads before and after.
> >   - valid rule with no trailing newline: unpatched -> -EINVAL (the size
> >     underflow); patched -> loads.
> >=20
> > lib/string.o is not KASAN-instrumented, so the over-read is caught by t=
he
> > vmalloc guard page rather than a shadow report; the confirmation is the
> > page-fault oops with strsep()/ima_write_policy() in the trace.
> >=20
> >  security/integrity/ima/ima_fs.c | 46 ++++++++++++++++++++++++++-------
> >  1 file changed, 36 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 174a94740..7b530b130 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -526,12 +526,10 @@ static const struct file_operations ima_ascii_mea=
surements_staged_ops =3D {
> >  static ssize_t ima_read_policy(char *path)
> >  {
> >  	void *data =3D NULL;
> > -	char *datap;
> > -	size_t size;
> > +	char *datap, *eol, *p;
> > +	size_t size, linelen;
> >  	int rc, pathlen =3D strlen(path);
> > =20
> > -	char *p;
> > -
> >  	/* remove \n */
> >  	datap =3D path;
> >  	strsep(&datap, "\n");
> > @@ -546,21 +544,49 @@ static ssize_t ima_read_policy(char *path)
> >  	rc =3D 0;
> > =20
> >  	datap =3D data;
> > -	while (size > 0 && (p =3D strsep(&datap, "\n"))) {
> > +	while (size > 0) {
> > +		eol =3D memchr(datap, '\n', size);
> > +		linelen =3D eol ? (size_t)(eol - datap) : size;
> > +
> > +		if (eol) {
> > +			/* NUL-terminate the line in place, within bounds. */
> > +			*eol =3D '\0';
> > +			p =3D datap;
> > +		} else {
> > +			/*
> > +			 * kernel_read_file_from_path() does not NUL-terminate
> > +			 * the buffer, and it may be exactly i_size bytes long,
> > +			 * so a string walk off the end is possible.  The final
> > +			 * line without a trailing newline has no room for a
> > +			 * terminator; parse a terminated copy instead.
> > +			 */
> > +			p =3D kmemdup_nul(datap, linelen, GFP_KERNEL);
> > +			if (!p) {
> > +				rc =3D -ENOMEM;
> > +				break;
> > +			}
> > +		}
> > +
> >  		pr_debug("rule: %s\n", p);
> >  		rc =3D ima_parse_add_rule(p);
> > +		if (!eol)
> > +			kfree(p);
> >  		if (rc < 0)
> >  			break;
> > -		size -=3D rc;
> > +		rc =3D 0;
> > +
> > +		datap +=3D linelen;
> > +		size -=3D linelen;
> > +		if (eol) {
> > +			datap++;	/* skip the newline */
> > +			size--;
> > +		}
> >  	}
> > =20
> >  	vfree(data);
> >  	if (rc < 0)
> >  		return rc;
> > -	else if (size)
> > -		return -EINVAL;
> > -	else
> > -		return pathlen;
> > +	return pathlen;
> >  }
> > =20
> >  static ssize_t ima_write_policy(struct file *file, const char __user *=
buf,
> >=20
> > base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
>=20

