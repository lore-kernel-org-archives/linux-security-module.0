Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66E2D77E6;
	Wed, 17 Dec 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977927; cv=none; b=kf/AGOZcz2lYgq4ZUssoFSKl2SjA0pOF4zGHwreXJE+N+kKGDY0KWD7WmZSTNTMhU7tJVKXYW8ZP7JUu8EapzetAE9t0oepQBLfHp/uBbiaNGMRw0J9XTLqHOjL/D88F+Hc1mZMpW2VLYkPwP5APoeiCX1Bdmr4wsyat2ypRE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977927; c=relaxed/simple;
	bh=Rsn+xJhhoL2xDbJO00IMdqExKuBfUiWjRhfv8Ha9jDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3cxrUutlbFMrb0AKLOwH6mg91RK2uVa9Gm4YkDYOguQwNfyqeJhvGjjgDI9/sm3SH6dc5DiVb3qA2obUJylqF7qTNe15N6BVrL6saCkVjcf5ofdiGdhft9lbUaanf+VStnfMIjt5GNKc0R3B40wKoPbIRDTo+EMwxDTEW5+X5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5kwsHnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5kwsHnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009EBC4CEF5;
	Wed, 17 Dec 2025 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765977926;
	bh=Rsn+xJhhoL2xDbJO00IMdqExKuBfUiWjRhfv8Ha9jDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5kwsHnbvSZGwEuM/errAiks5gh2JoIw0+nd9hIB3pI5qdIKvZXgT5KVdmk57klvK
	 S1ze6rLCh8xBjPpDAmfj+d8xMHNZ1wYzgnqIdvFbTDyOUfJr1D6WFLCk4B+5ZpCGEl
	 prRkl6wlSLAtIQq/+JPxyPiApBhPayBYAQBHH6toiBW+0IIIRTJczfsupT8tA3wFPp
	 he1nMiUv2QBDqg9gzKWiRMMMFaGer5J8JU6Ah4knTLOMSju/UrKPHS0By0TZrSWuul
	 0NceIe1Vwdq1c2gXjM8qNXtiSPTRKhe1+yg2J0RGzeRPqBax3usorZYb8RVjzuKNJU
	 1jqaFfD2uanBA==
Date: Wed, 17 Dec 2025 14:25:20 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loadpin: Implement custom proc_handler for enforce
Message-ID: <lm4wobozzuk5nherj7uvnljwnax66kh7e7q7a5enzjdxhudyzn@ijoery7pjzht>
References: <20251215-jag-const_loadpin-v1-1-6842775f4e90@kernel.org>
 <202512160028.8F11A5D19@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkg5gvdtsug4bw4u"
Content-Disposition: inline
In-Reply-To: <202512160028.8F11A5D19@keescook>


--xkg5gvdtsug4bw4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:37:29AM -0800, Kees Cook wrote:
> On Mon, Dec 15, 2025 at 04:43:48PM +0100, Joel Granados wrote:
> > The new proc_handler_loadpin returns -EINVAL when is_loadpin_writable is
> > false and the kernel var (enforce) is being written. Move
> > loadpin_sysctl_table to .rodata (by const qualifying it) as there is no
> > need to change the value of the extra1 entry.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > Const qualifying ctl tables is part of the hardening effort in the linux
> > kernel.
>=20
> Ah yes, thanks for getting through these "weird" cases! :)
>=20
> > ---
> >  security/loadpin/loadpin.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> > index 273ffbd6defe1324d6688dec5f9fe6c9401283ed..f049c81b82a78265b6ae358=
bb2a814265cec9f16 100644
> > --- a/security/loadpin/loadpin.c
> > +++ b/security/loadpin/loadpin.c
> > @@ -53,18 +53,29 @@ static bool deny_reading_verity_digests;
> >  #endif
> > =20
> >  #ifdef CONFIG_SYSCTL
> > -static struct ctl_table loadpin_sysctl_table[] =3D {
> > +static bool is_loadpin_writable;
>=20
> I would rather that load_root_writable were declared external to
> loadpin_check(), and then we could remove set_sysctl() entirely, instead
> using load_root_writable as the thing to check in proc_handler_loadpin().
This seems like a better approach :).

>=20
> And also rename load_root_writable to "loadpin_root_writable", just to
> make it a bit more clear.
And the default value of loadpin_root_writable would be false. right?
Something like this:


diff --git c/security/loadpin/loadpin.c w/security/loadpin/loadpin.c
index 273ffbd6defe..650073829db4 100644
--- c/security/loadpin/loadpin.c
+++ w/security/loadpin/loadpin.c
@@ -53,44 +53,40 @@ static bool deny_reading_verity_digests;
 #endif
=20
 #ifdef CONFIG_SYSCTL
-static struct ctl_table loadpin_sysctl_table[] =3D {
+static bool loadpin_root_writable;
+
+static int proc_handler_loadpin(const struct ctl_table *table, int dir,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!loadpin_root_writable && SYSCTL_USER_TO_KERN(dir))
+		return -EINVAL;
+	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
+}
+
+static const struct ctl_table loadpin_sysctl_table[] =3D {
 	{
 		.procname       =3D "enforce",
 		.data           =3D &enforce,
 		.maxlen         =3D sizeof(int),
 		.mode           =3D 0644,
-		.proc_handler   =3D proc_dointvec_minmax,
-		.extra1         =3D SYSCTL_ONE,
+		.proc_handler   =3D proc_handler_loadpin,
+		.extra1         =3D SYSCTL_ZERO,
 		.extra2         =3D SYSCTL_ONE,
 	},
 };
-
-static void set_sysctl(bool is_writable)
-{
-	/*
-	 * If load pinning is not enforced via a read-only block
-	 * device, allow sysctl to change modes for testing.
-	 */
-	if (is_writable)
-		loadpin_sysctl_table[0].extra1 =3D SYSCTL_ZERO;
-	else
-		loadpin_sysctl_table[0].extra1 =3D SYSCTL_ONE;
-}
-#else
-static inline void set_sysctl(bool is_writable) { }
 #endif
=20
-static void report_writable(struct super_block *mnt_sb, bool writable)
+static void report_writable(struct super_block *mnt_sb)
 {
 	if (mnt_sb->s_bdev) {
 		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
 			MAJOR(mnt_sb->s_bdev->bd_dev),
 			MINOR(mnt_sb->s_bdev->bd_dev),
-			writable ? "writable" : "read-only");
+			loadpin_root_writable ? "writable" : "read-only");
 	} else
 		pr_info("mnt_sb lacks block device, treating as: writable\n");
=20
-	if (!writable)
+	if (!loadpin_root_writable)
 		pr_info("load pinning engaged.\n");
 }
=20
@@ -168,8 +164,8 @@ static int loadpin_check(struct file *file, enum kernel=
_read_file_id id)
 	spin_unlock(&pinned_root_spinlock);
=20
 	if (first_root_pin) {
-		report_writable(pinned_root, load_root_writable);
-		set_sysctl(load_root_writable);
+		loadpin_root_writable =3D sb_is_writable(pinned_root);
+		report_writable(pinned_root);
 		report_load(origin, file, "pinned");
 	}
=20

--=20

Joel Granados

--xkg5gvdtsug4bw4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlCrz8ACgkQupfNUreW
QU8k4wv/eZJ77hTRTOFUmY+x0jeZGlB4NkjX0+11BW1VDkBsqZkWsNpX0nUZWscd
xMMzhk1KpEYuhqqBt19MPUd8JUggPOMuKtpQWJCwnuE+6bCJEs3AuPwUbt2fut/j
DFwHfMCQBkXUQqfsj8sLF1XmkYfctLruyIgvhsAUxg/yKVHHZi19wKrCRpcrcBjn
fvXcVRDFVQKH4gn0lmvCatckySaaiypkQTnnWQYZU+Gc46kdnRn8rmpJFfZC0zRR
WCHo+axUGGgLOVcIsfmVImfTEXqJ1vdRIpd073SlPBdiepgbullYr0obqldib1z1
7gf7Mngu1IDPWZEkK2q80cPplY78Nxj+zEFKfKfcuk0qVhLgou0cipCDa5TCD03p
vbVXd5ngqkDJCc7ayh/s+ivbGrL/4cI6xwbwo1VQ07BQGVrbTg8BKQamTB+KqD5q
OoOjCDWVE2JnWzUyFf4lR7kABXBeXlHsWKG22UxTbJumBr0aq7nzGKGFld3u9oWW
Wyh5OpgU
=blYk
-----END PGP SIGNATURE-----

--xkg5gvdtsug4bw4u--
