Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF38547048;
	Mon, 21 Sep 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985897; cv=none; b=q6O3q6yiD9agZMbmfeqid+UXUqoU/SX9tK6f35UmrgGlpJuncfVRr2zK05svReucyd+9KECC4vGdEWCpXnZ6YYYNB1Tfwiw6RpH2DaWuL/0tqP/2+lZ6Y7IYLHVE7/6kPzf0uYN2fLnZ+dCxGRat5mrZluazBDgYR/y7Ax/hMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985897; c=relaxed/simple;
	bh=akkou26yaO7zMdmAUOXT9IxpEFq5MFadowvbIkoJUGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hkS50MNOgZG1njqF/U0kC8BcpdPo//w60ryeVA1F2EoKsOseCZUq+0g51k+xrpvI25MSZv2TbiV3eEyBHzMnm4FzZI/sh/sZWC08m9rCB5e6w2OqxubC8QKP8X3B/tGW3MvxOQdJqUv+ItnOiLcOhb+9IB8MiDDme0g9z7JoP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjzIZYXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjzIZYXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211B41F000FF;
	Mon, 21 Sep 2026 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985895;
	bh=akkou26yaO7zMdmAUOXT9IxpEFq5MFadowvbIkoJUGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjzIZYXcUhmZWEsG43aEDd56uDBcsr/6B5rsbS7ou8IvUlRBd1vjN8tPiomV1IN+R
	 GAUdhIp9pz4YRF60SyPEBpkR4BULsxHP6KquEMvyz8YBhKKdZ8U25MeUYibjK+Mmoz
	 LmIor0l68Fa9uxk+e4MWULkFjFGrspT42hvxxoPdD4LbEE96ZyZPzauubDlEPEWmxT
	 xtzlP0trJawmnSPdFgmLT36GLU52ccPR02wy4og4+gYVMc7AHNgUSWmssl+kH2hPM2
	 HcxyGbqBMGDRqayRx80O06WsNjs0etMIo1glMEEXytt9zu1ye2yFJ9FbsOAYhoZ0+N
	 IG6qjqsQor6KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/15] rcu: convert process/thread iterator to
 for_each_process_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-10-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-10-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:18:14 +0000
Message-Id: <20260921101815.211B41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process_thread() loop in kernel/rcu/update.c with
> for_each_process_thread_rculock(), which scopes the RCU read lock
> to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D9

