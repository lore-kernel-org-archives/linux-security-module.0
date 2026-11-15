Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751548;
	b=zbgaNLJnv1Na6qKmcfwr2zFRoMGNRjA7xVlZt7kcj9P4tLLXgtcx5mdn4DJEDn+PNmVA
	 TiqpmCSrOQpV7w24OlQjyjERRMKE5EAGuaNkt/24bWRzqWK3yIH3c2EsdDvf7ZLmBn/R7
	 A2mJmYf+pX5uEP/+a96VymWO0kBwMvljL7hq3q91v822YLxSKgYWriG0bxGUEeu5i9mRs
	 dyiTLoiy7MV2Sg2TCHfQXiKSrUf46oPNzhFo0f/Y1JxUxd1UsSBLvWsSItB/OlNd4AayS
	 PwBNQgwkgKUa8x9L04GelmnjanSe02Sc+60RZTKkULf2s3p9OL3P1waStm+5UrIXXuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Z3i2CN3CXQaoN6DlhpVKHrI/npH0jw9jVlLB809n6o=;
	b=DH/GB5pfcnF7NSWg/rn2dvfS8I2aPn9H0K4uWNg7URQeYCiBn+9AqVCIxX5RlLJ+r2TD
	 dfTfaswtF36n3rTi4V/uWdXgIa3kG4lvY/EuiRN+pOlwrjq0zRKxXlaVxNfB7N4yxoXxv
	 UO5mbOIm1orsIdsWGqFhMZuQf5N/aSU4a7ihrqI5HMrm+oM/yYHv59Mblkl1Elh5EN3xa
	 mhotAWRqFh/imRRn4PpFKV3WGS+OO6H1MlOGRpWq1be4CPB5Z7DoRMF3HyqTzvulcoJcW
	 SFvuGWHsVujKXpwAT9TMG6uG6BtGmvTUqfH7Z2UafFnQtrJV9trGDxnwDJAjq2jFkWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA3xzglk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37979606A323
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA3xzglk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F9A1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751548;
	bh=3Z3i2CN3CXQaoN6DlhpVKHrI/npH0jw9jVlLB809n6o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LA3xzglkza1rnJ9W7i/zcDkFPBXz6F+olnO+KU4VDUzEfm1o/IwOKyqV6bysyXepc
	 gPIomGC1dtyHXbZBbMZUfwHTUW/FQLIUAyq2cecimfCGC+KKIuB45H+Ttrdy9H8sqQ
	 YQscfieGFAcVcT+ciOfXfWdctRfm7/kdXD904tbzwSdbq2t5wMuktGPGITuKQtp1Bl
	 lVipMXJyO6OEGq5NARk6l/g259uziglD20EqyF4pfYj2P/ssmH6jGLXudr2jpV+jKC
	 PfJRYq/gmblERQknejd5kVeqGNQYrlmwsTwnLkWP8XxTZdqt4Efxz711ZNjKX/9iY/
	 Ppa06o0Cimr1g==
Message-ID: <sashiko-outbox-215553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] fs: add d_real_data_inode() and
 d_real_metadata_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:05:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>=20
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>=20
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>=20
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
>   if that can't be resolved.
>=20
> - d_real_metadata_inode() returns the inode hosting the metadata. It
>   never has to look anything up and so never fails (but no promises for
>   the future).
>=20
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>=20
> No functional changes.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D2

