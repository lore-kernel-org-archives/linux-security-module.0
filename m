Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88935C6AA;
	Mon, 21 Sep 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986747; cv=none; b=pabXYvioWpuQVVZGsut4c28+evUy7RvM2MIkaCs8BQCsslT0+u4dcribkFs/jRBT7oAFkb3auT4eKyKQ3p2rUPwMqOA9HBZS+2yUH470YvoM+eion3ymzDAjrIC3Tf5gPzoXta1zYuWgqtMTsEGISpwMum8Q8EQ/jlwju4+57XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986747; c=relaxed/simple;
	bh=mylqMMttOa1v+Cez10C5MwHgPIV2GLEkEoSXKCBX0Vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRNPOkzEaAEt0IsG2mqeowIWpPAn38VuRrKomKaVg3pEzjGVXt3q/nI7M8q320KzuIPYD+3BbRFD38OiF/o5n1EAiipQ4vjER6RdhnZn1en4qCsH3sLhV7j7a5z+u6oTTB9znnJ9LfzakFcO06tk+tjKCFuF3hpIQMEn7m/AcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUCv8YjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUCv8YjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EA1F00893;
	Mon, 21 Sep 2026 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986746;
	bh=mylqMMttOa1v+Cez10C5MwHgPIV2GLEkEoSXKCBX0Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUCv8YjC9uzUnaCCrJ9jdYGCozTDj/715BMI4fLAnWYcUg8mp9cTrGH0qR7nzezH6
	 eXvnEvZY9Os2tf+JW9eZ7fSpjyFOkPAr00w7ibitC5efZb2HMm2oAF/S97htnePUo/
	 hx9aMpwFsCy0f0O03rGvcZYXl/5+bxAsXJr4bE0lr0okEKvRYWtJhEIP0v8MO27l2i
	 35Iir24Z8SzPrvUnLiv7Rl5UI3uk8sw/jyeDKcoFaQKVCUO8Z6k5uauMZH39MaZmJM
	 oOYLBbZ43NxnYqbVbsblCkb2wAw2wX4baRgxEsgQowttT7V/MKsfCafZEyXeRNe7HN
	 CR0DNLrAbHl/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/15] unwind: convert process/thread iterator to
 for_each_process_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-13-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-13-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:32:25 +0000
Message-Id: <20260921103226.087EA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace guard(rcu)() combined with for_each_process_thread() loop in
> kernel/unwind/deferred.c with for_each_process_thread_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D12

