Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A44137A1
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343843; cv=none; b=PTWZecw97kSlOT8WL3J/e5PBsXiydgToWeNK1h+NSnmTMUkis2YaWvyeHEcmV92+U1CBnUc/ZhEMDkA/kdIUX8klbKVN6C5R0nc34mDxBcLYZGuuXqUUlq+mZuECI1DRNw6lI3nkc4uVqQS91s0Vglv56CcLLEdbPlkLjhCo5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343843; c=relaxed/simple;
	bh=YLq8NVM17BAZOGr2iiE01sseFUE2FR7/MZZWnZ3H8ds=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Nb3RYLkEHHpARMOw6uCEWTACOn99ifinurKt4jGX6AzDT4nJVq4nhcqL68X+kdTRs5JtsZCyB/pM0to78JRYVfCZWakiP1CrSFI7gteiqMtq1/uJooA/HKj2w4x+Lx5bwf/w8bv0VWPtMVRLQ+5SxRzQTTa8AHHMZ2uRmagmQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt3zX1KH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt3zX1KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043CB1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343841;
	bh=50NFkx1avWvVA4BvRciF44icNHnhsQQCO5XWmWHYxO8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Tt3zX1KHDfF7GN8rToRYoC3L82u2tV+yhhYHJcuFZOzjCOw62yntxcAa3bVWr8dXz
	 AtgfBTrHIbvS3incRBOktGPtgIuNfBY7TvT77b3VnjUgUXH+KGn5RAmH3NezHb7EVd
	 C6NfFrnB0UY7yIn3iZjmZZx3T0xuOVMPMvgP5RkEQ++xKpNtGoBSwvr9EkAm0Oj1fl
	 Jc14oGggqsTW4ipLXhZ0SWlfLmPNHQlx9HO26ahBhOI0UnM0tCgHxPL09LLKpVDhUk
	 pj2MWYp5EiewIFsVmPgRwtfMQTBdHsbXcsnDC4tMXvOz9sirebk3itF5RnWcCZNpZz
	 6Ge1EmRFVM5KA==
Message-ID: <sashiko-outbox-176312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] pseries/plpks/wrapkey: expose PKWM wrapping key
 management to userspace via sysfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-10-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-10-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:17:20 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The PKWM trusted source currently uses a single default wrapping key
> created during initialization. However, PKWM also supports user-created
> wrapping keys for better isolation between trusted keys.
>=20
> Expose wrapping key lifecycle operations through sysfs to allow users to
> create and manage their own wrapping keys.
>=20
> Create a sysfs interface at /sys/firmware/plpks/wrapkey with the following
> attributes:
>=20
>   create        - Create a new wrapping key with a user-provided label
>   delete        - Delete a revoked wrapping key by label
>   revoke        - Revoke a wrapping key by label
>   unrevoke      - Unrevoke a previously revoked wrapping key by label
>   list_active   - List labels of all active (non-revoked) wrapping keys
> [ ... ]
>=20
> These user-created wrapping keys can be used in seal operations via the
> wrapping_key=3D<label> option.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D9

