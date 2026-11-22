Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377482;
	b=MlG7FmFOxQr3Bbk4yzYHDRl6/ycv9s9llm+TDeiVMDI6npQlyD3ngAbbyqHghNwFj/Pc
	 EbDB0DBHyRwFgF7WzbFEqkCokrg8lI0U3wxjMXx0F3dhPHSAaWPUlVAE/it6l7anRVNoG
	 ZM+3aA40hfREtYMLF3/f6ElRL26zaFvwAcE5AHiEmg5WE++Ty1LqBHLqyWeMFcfYzxhrF
	 Q2RiUXOsY0G6tYC1MakCZCGxaI7ovMp/sj1cbcJ+w81WrkLjc+2dg7Q1mo72oebSfAocv
	 J0x64scbUqjOK0AFYBesHVmN+mT/vHdfYn0jHP0fm8x/X1OQOHEsHVbQDReVIOA2OuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oMjuXZHrlWPPpEnOYgTwySt1wuMEHljtGxmgjNiSpZ0=;
	b=Nq+7vAHfoGMOaDO+IaCKl+5RVXaIS0y+tCS5ZbD9jvmCNbdsmOpu30pariEG+y1aTpb4
	 dhkJYaSAs3vcl+roCM9HnnMZMIXoSCLG+CgKSG09YZ9t8T1FT6z0dBSFf/gwIQnOt4my9
	 uakWwMzIzR3rt9BqZTJgTpGy2xVvT7MyX0VdH9l0lAsaY83fi+4Soazd+1Sp7EUXe4pXk
	 coVVQCX8FPpeI4IHZUmrr1s5bSx4FRZ4W3WqwnQrqCwTvo8NzGytb3N9AzWLYhyVXBJPu
	 DolRwX88AFpXirF318iEjjRjgScEUUrtoMv1W6JvZs6rWgqtbQDgIbGylmT70PE0sRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdPRWHMt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F74606A31A;
	Sun, 22 Nov 2026 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdPRWHMt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01691F000CA;
	Sun, 22 Nov 2026 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377482;
	bh=oMjuXZHrlWPPpEnOYgTwySt1wuMEHljtGxmgjNiSpZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PdPRWHMtve4aQLIFlHZ+0HHOep+xUOPCs6yEabDNzjy8BU1fG4VCn+DChnNH6AxZc
	 0oo1Aq6TCbPOStHYJd8+y8No/Aaj5J0JE/4NnBvUuINuiQtJVDkSURWIVh10XMLdxj
	 EfLqTi/IBZYhCVzMMFGL2BpuWEsQWnooOgWXA7bgHowKYad2uIaCCYaWMk6Rkd+e+z
	 013aPwBMbsXVFI0FtMpbg/jlR2Cwnm9mQjvej9HqdZsK8fQ83+Jlnp3qLz5nV2Jg9y
	 ZnuCk/7RZejxCUctlErrz/SVQDMXEwykvC9ZwXpuK947q46PmGz13I7b0NTMDHjfdn
	 snb/j8v+qCB7Q==
Message-ID: <sashiko-outbox-228300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 18/26] fs: Support FSCONFIG_SET_USERLAND in
 fsconfig()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Aleksa
 Sarai" <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski" <luto@amacapital.net>, "Arnd
 Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>, "Giuseppe
 Scrivano" <giuseppe@scrivano.org>, "Hugh Dickins" <hughd@google.com>, "Jan
 Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "Lennart
 Poettering" <lennart@poettering.net>, "Neal Gompa" <neal@gompa.dev>, "Oleg
 Nesterov" <oleg@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Zygmunt Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261122193539.3334213-19-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
 <20261122193539.3334213-19-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 19:58:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] devpts: missing fc->user_ns uid and gid mapping check in
  devpts_parse_param()
--

commit 5f6b9ba4a78b24bfe4f6ba168eb1ea41dd809f38
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support FSCONFIG_SET_USERLAND in fsconfig()

This commit adds FSCONFIG_SET_USERLAND and the ->set_userland() fs_context
operation so callers with CAP_SYS_ADMIN in a target userland's user
namespace can bind a newly opened fs_context to that userland, and marks
tmpfs, ramfs, and devpts with FS_USERLAND_MOUNT.

> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb7..921b67d18fa2e 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
[ ... ]
> @@ -457,7 +459,7 @@ static struct file_system_type devpts_fs_type =3D {
>  	.init_fs_context =3D devpts_init_fs_context,
>  	.parameters	=3D devpts_param_specs,
>  	.kill_sb	=3D devpts_kill_sb,
> -	.fs_flags	=3D FS_USERNS_MOUNT,
> +	.fs_flags	=3D FS_USERNS_MOUNT | FS_USERLAND_MOUNT,
>  };

[Severity: High]
Can opting devpts into FS_USERLAND_MOUNT allow an unprivileged user in an
outer user namespace to configure opts->uid and opts->gid to host UIDs and
GIDs that have no mapping in fc->user_ns?

When a caller binds a devpts context to a target userland via
FSCONFIG_SET_USERLAND and passes uid or gid options, fs_parse() resolves
fsparam_uid and fsparam_gid against current_user_ns() rather than
fc->user_ns.  Unlike shmem_parse_one(), devpts_parse_param() does not
verify that the resulting IDs are mapped in fc->user_ns:

fs/devpts/inode.c:devpts_parse_param() {
	...
	case Opt_uid:
		opts->uid =3D result.uid;
		opts->setuid =3D 1;
		break;
	case Opt_gid:
		opts->gid =3D result.gid;
		opts->setgid =3D 1;
		break;
	...
}

devpts_pty_new() then assigns opts->uid and opts->gid directly to newly
allocated slave PTY device inodes on a superblock where SB_I_NODEV is
cleared, creating character device nodes owned by arbitrary unmapped host
UIDs and GIDs inside the userns-mounted devpts instance.

Should devpts_parse_param() check kuid_has_mapping(fc->user_ns, result.uid)
and kgid_has_mapping(fc->user_ns, result.gid) before accepting Opt_uid and
Opt_gid?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122193539.3334=
213-1-jarkko@kernel.org?part=3D18
