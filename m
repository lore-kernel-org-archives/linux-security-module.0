Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290167;
	b=brX+xYTEPV115H0UnJxqAe0EevlCtD13XEHy3nnmPSBdS6HaarO+XUvFF/7/1fH+en4M
	 oZNOik0TQ2hW8Kwuh81qAxn8DJW7XVoLMyx9KuCvnNmd6JjMH77mPKByMDZBdVeTf5xj9
	 GOFG+d+DUSfAJAdp+/4OvJ0sJfHCkdADIlwMR1WRfTjR2OJI24WPJaWovdXxITfAIGMIo
	 PZpnHnN+qnvYDcv4kYZ0KcbFp14UPw4G47v1wdFMPpvykATQ7JoywPYMzjFAVklTLjp9o
	 egpmUlkTOTAxrzpeyFOY7YGDDSGgWfO7oEtG2cTdwIabe0ohGbYj0PXq7c5h1obQayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tO6g1JASX7rXQj3OY5h1E253G7EzuHoEJJUb09vcGfc=;
	b=qcyGcZPRQbj2UEpo6Z20cUwtmadqFQCONvSEiMFjXj4j82Bu0y8WbhnEv+ImF4wanxCR
	 ONrBTkdd4CMvVRSHipr4PKWjpKw1xhIgdRGzHp6Aq1xczLyRc3Xs9OsRruvxz4DDgBnFe
	 pHygUcPoB4m21imKzYCuBBehSX0rgHCCDYzA1NCCQ9crqsiSbku5F8V5AXXk182c/K230
	 LS5SUa5gEueoTOPDc8uMk8aOTadCTwJwhmZOM3uFSQHsZXYVi/SQW8vIQMAtODgNskKdq
	 6BVNKTPT/lvhL1gnp4zg1Fys+XFbwxkVFiXkqvnCuIXMKJqkntLBoDin81trxM8MpbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSYYZ3Da;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE160A6F69
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSYYZ3Da
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64431F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290166;
	bh=tO6g1JASX7rXQj3OY5h1E253G7EzuHoEJJUb09vcGfc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JSYYZ3Da5aNpIBnFesiJbIdcizSQzmyRlc8SGRFNIaw9SVntOQslGs8US/7wPq/IF
	 VgHvKcICums3RGxGZe14ULRQg3oWtN3f+F93CgcwZsogTZaMx8vBQyB3WxQ1p5lWs7
	 h5ImZocD0txmgR7OoMHDcjXqQimzD1iWujB+b2GhI58+nIbOoDuefu09927aH6gUJ8
	 LGZuHiLHz0LNROFDinSbz17dOfYYWpnFEFBklEawoDiscQCaLngFz4PkPWmZeVCyxz
	 RFuvVOIi73f33QGkbxJAJRm5wHHMr7CFok96wLDbl1jzhnE49ZLl+oIRm5NHKsnElJ
	 nzcV4ffRbC97A==
Message-ID: <sashiko-outbox-189649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] smack: do not override the subject label in overlayfs
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029155422.578322-1-m.moscicki2@samsung.com>
References: <CGME20261029155517eucas1p25b05b501c3f6a8c9b58c145898f6e76e@eucas1p2.samsung.com>
 <20261029155422.578322-1-m.moscicki2@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:09:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Overlayfs performs operations on the upper, lower and work directories
> with the credentials of the mounter and uses the inode_copy_up() and
> dentry_create_files_as() hooks only to let the LSM choose the label of
> the inode it is about to create. Smack implemented both hooks by
> replacing smk_task in the override credentials, so the label of the
> copied file, or of the transmuting directory, became the subject of all
> access checks done in the underlying filesystems on behalf of overlayfs:
> the lookup and creation of the temporary inode in the workdir, the
> rename into the upper directory, setting the overlay xattrs.
>=20
> Unless that label happens to have access to the workdir and upper
> directories, or is allowed to use CAP_MAC_OVERRIDE, these operations
> fail with EACCES:
>=20
>   lsm=3DSMACK fn=3Dsmack_inode_permission action=3Ddenied subject=3D"some=
label"
> [ ... ]
> Outside overlayfs smk_create is never set, so there is no behaviour
> change there.
>=20
> Fixes: d6d80cb57be4 ("Smack: Base support for overlayfs")
> Signed-off-by: Mateusz Moscicki <m.moscicki2@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029155422.5783=
22-1-m.moscicki2@samsung.com?part=3D1

