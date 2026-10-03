Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DB2E975E
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996136; cv=none; b=n3xUnq7JrWDhS5C3luVZaxTiOrUjdT2DP81jCaJg2VHGo2pFcmlIx9wZzYuvIG5UtFv349HGBJc0e/UPBP713BfArGkNQhYWZJBQtfrgBhMxw/Deey2CTpHraFeZeBt/ra3JPtvDYBYf4KSDRC8PxLTmw0levuiG8pXqVrxB+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996136; c=relaxed/simple;
	bh=KiH2vafN0YoHsUNNunGb+MbnpK0bclCfa6v6vHmC/fE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UYHRJFbMvO6NgBHz6NrOga+mHIOJDsVYQqa/t8MKSZIU2q3r8aa+0c9BaugmpI6lPteFgYgKgiEkgRxmgSO+m0b0fCyyUPkUe7Vo8mQm8iGFeUry7BQnC1tDmjTy3bLGqx8wW1uUTcXDBxEGMnsgamrrjLA8+VQQ0JjzGvVqR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyJXbQa4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyJXbQa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E425B1F000FF
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996135;
	bh=KiH2vafN0YoHsUNNunGb+MbnpK0bclCfa6v6vHmC/fE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PyJXbQa4KA54VfuNTRPcQSEOHAODTGwDALztAHi6YosztI1kYYuiQd4VLVuie5bn3
	 pDtxl0mzHfhJSCcbS+sGDFRU5NkpFAZGA5459m0aEGCxZMtlSGOBKMpEklFpQMi6ds
	 oIK1GYJfo+fDvtF6BjPmwN7+dhb+dNgiCw0DF7sJD7GW5Q7UDRTnUU/SNXZ11bZwPV
	 6Wnvqk9cWV80/cDTSIKH2kwRlHLbYXlGLjfLrYjT4l7YprUYS9d+ZEgqm2c3CLN393
	 ILsUc2aJpDXvqPJGVzr2CGBsKwFu8DVrFdraJsTxlBDhCu2pIP2hJQV4dew+9lQnH4
	 vb2Q3vXUppiSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] ipe: fix enforcement audit
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261003025135.3666767-6-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
 <20261003025135.3666767-6-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:55:34 +0000
Message-Id: <20261003025534.E425B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> ipe_audit_enforce() starts an audit buffer but writes the state change
> with audit_log(), which logs its own record. Ending the unused buffer
> then emits an extra empty AUDIT_MAC_STATUS record.
>=20
> Remove the unused buffer and log the state change with audit_log()
> alone.
>=20
> Fixes: a68916eaedcd ("ipe: add permissive toggle")
> Assisted-by: LLM
> Signed-off-by: Fan Wu <wufan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003025135.3666=
767-1-wufan@kernel.org?part=3D5

