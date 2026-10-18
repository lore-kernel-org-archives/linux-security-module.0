Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03F1096F
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343609; cv=none; b=USbhmm1ArLL6u6YnawNXqP2k6tI/1LUhn/cTCSYqoq10MlaE/+XapSCQE6l1Ii/RkLuINYuHoAfMap6YsDLpdzvkQuxvTPQe+CzS32kASFo+vhJAi8KRbrBjiyuv5qFv77I/BCcPBgPZrZOBysPqhJVVQXYMfwExNPtx/4DCOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343609; c=relaxed/simple;
	bh=hqJqd80QzJnbHVa8YuOmOGTvEIZISC43fy7f+YszbUs=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hFw3Y9/7s/kvUCZCq9GE6xv1Gx4jH0gppu9nvqvaSXdCE9LpUyXnZtpeq8K2DQ13s73zgMlhihxLiFBuCyqP+9zoh6H4vXjmUa74d5gl95kTqyG308x0tYIMzMcxJEzsDHhgsjkYbSWaitSvxcFhvYfWNbvj8taDlywC6I4zrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QByvRIh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QByvRIh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E81F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343608;
	bh=hqJqd80QzJnbHVa8YuOmOGTvEIZISC43fy7f+YszbUs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QByvRIh75glBUkhdUqfGrrkr58jNcoMgMmMK+0OmA8AyXPXjBuZJyAlx1+pQpjMOb
	 dFyDOpnmEzwv+WARZ2n72dmnttZU3x+v/ZgbVKyYQGWkHXe2SJ19cwTu9y2RGhH1fB
	 mCuIzIksXmP6BurEUVRZzJnRfe7ZbOrlB8dChDSrYKFkkBrHtp8nS+TN42uKTWlIeH
	 +ThFC8CNT1InTpIginPfAT4qTaDIC48q/huXj/Z8IHtvVOdvHMmK4xRHUG2ghrmS4/
	 43I7coR92NTGxdsXCSLxUKuNx9GCPo0TGz3tFULyEgeu1ldVJLAl39BqDuns+sWe4r
	 zcPUoetKSqyfQ==
Message-ID: <sashiko-outbox-176308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] pseries/plpks: fix double conversion of wrapping
 key flush errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-3-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:13:27 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_confirm_object_flushed() returns zero or a negative Linux errno.
> However, plpks_gen_wrapping_key() passes this return value through
> pseries_status_to_err(), which treats it as a raw hypervisor status and
> converts it again.
>=20
> Convert only errors returned by H_PKS_GEN_KEY, and propagate errors from
> plpks_confirm_object_flushed() unchanged.
>=20
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping =
Module")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D2

