Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA339339389;
	Mon, 21 Sep 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983680; cv=none; b=FlYjMpmdESgasYZV974cpnuq+4rhCN/dPitr2l0M7gqiqGxNcaodcSK92nsSFxA5Qe2PqJuudhvoXy6wuZi4NorfSPFbdLvOKe+D9Gyd4itK8+VKncFdrhQswShdsP7Qysjy+YWHc9uoEcN65wWUqA/WgSE6qfFfxw4NAp7iqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983680; c=relaxed/simple;
	bh=R7F/otBY0YF+9Z8GlD32A4j4/znCfy4lGY+o8kykMs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2gOZ1CBKr6WVL/B2PTtTQtvbggp5c6IXqbreYs5ZzidPily9NbHTAaCSKHNAZ27Q/K1zZ4fbXPPXN+Z5IfRCAsfrLzfEVH2QHhkpbJADsol1Ea9NmrwQMj3+Q6p/HnT5ref8r5WZBcSMhnvBexW1+N2v+8iR4+aCqXCxzISXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apoy+4Ft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apoy+4Ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB91F000FF;
	Mon, 21 Sep 2026 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983679;
	bh=R7F/otBY0YF+9Z8GlD32A4j4/znCfy4lGY+o8kykMs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apoy+4FtHO76MeSfvuK4yDN8+TWD+bTrbkBFtCTJv6wZw5F3jTdv5ust6gEyKyySv
	 ZKVKoseUpDYURd2mFPp9joxYa3larxxqgw7932VJYsS+qyxozYrX44iRv+pQZ6/FNg
	 VCTWsU3yii5WWNRjTjNLFNhzwnNYsJHLl9LIXD5DGjXZmF1Nv85eTpr8JnqXWbW+RD
	 8FVF1TmMyNHcMTtZD43l69IY2FAa15YajpBUGCYoxCc64BqtQbZp4as06pQMMviWbc
	 htuf4M/5T2OZDVLtetnA+Q+Dc3DOEDGFum/Y5dS+ibcYPERyb3amo4GHOpzCnxuEZB
	 TWHcBtNLnNpeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/15] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921092101.89285-2-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-2-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:41:18 +0000
Message-Id: <20260921094119.1EEB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D1

