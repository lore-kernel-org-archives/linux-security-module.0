Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447041;
	b=EgpsQCG3YxFD5eSWCE5JzuuG4PphNr0AOIL/pYGxY/cL88QnBvii0LCmrJqXZuToaAXz
	 Mh5l5jJSZ1AQewIyq/53XL4SeGG+bAWQa9R4JjHbu41YA1owAuLI2qDd4NC4FO/V+n5Ip
	 rrPu6jeHZOnOvEbsNt9wiBQzEY3w27XZ13DUccarE5MaCGJs+fgq7SsJ+8YoyaZbPid7l
	 KpAUQl2m/qdAWhf8f0odZ/85mimkVKaKCyNQ5yrYQJi4U67GuomUTXTCRzfLmwrScfAMy
	 v83O+d7ziw8SrDKWWLZ3SGvu2/jqQ+sfDkZORy3hLdqv0rG65SVJMNW76AY1eYekRFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MKj7glC7ZuV0NZIPGzkF3iyF1E2FueFtrb4gt/AWgv8=;
	b=KO1KQDW211GrhNWxatYpStnhhJiOJ4fYQQHreIkigWYGBn0bejp8qt2pLl6ikY+T6kz7
	 HRoetuUjN1VktaXuu+a8qeGJnRqmCuWvKf58YM26auF78d/2Oq6DQiOTEZsg5XG4vY6dQ
	 xag29qemwh6++y3hy93pjTBf34UfMlqHAjeitE6D4ueZ6I4uutpHAzAditmJhmIdTnP8g
	 mE1QsgqBEz21JT8iNxoXVvAwjcfiD4sJ407EP4bLzg4FfQuRPHaNJlXZELemV73/m73eh
	 Xx82I0hPMFpVyJtcO4eHE74GLZ0C+mB8zn4r4m+UIj2NdbOxXyVRURrCaKgo+l6gBIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZvhIbqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4E606A31A;
	Mon, 19 Oct 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZvhIbqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAB31F000C4;
	Mon, 19 Oct 2026 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792447040;
	bh=MKj7glC7ZuV0NZIPGzkF3iyF1E2FueFtrb4gt/AWgv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZvhIbqqbzR6PT3G3hJb6gFymOY2MrJrZal2iS3Mebpg8dmETAV7LHrfxrFLM6e7o
	 36fmI9/X6vqGQ+puKac1ycq/8kUAlrXDLkzCGHqT4PIs5Z6ZBWcRhnb5ATDLidZYHD
	 AwSNFEoGHTYJav+0yj7i4ltBBRWiz6k3uiS3rEiD8IHeP16zJuWiMReIsOTIDtlTZ2
	 Hf3JfvmVc6bxtQDbEQaGlHi1D0IAckUiytSEm93JzcMsyXBBioLgmgwfo1Jf7zZDNu
	 rFCPKEcUyvWpdEdY6rfNKAoIp5Npzoab1LZxRwi3MrO/XeMUlwzmvn3uLtMnCWcPqT
	 R05zfwYIV/TKg==
Message-ID: <sashiko-outbox-178282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] selftests/ipe: test the IPE policy keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Huber" <manuelh@nvidia.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-4-156f0b93e843@nvidia.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-4-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:57:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/ipe: missing CONFIG_CRYPTO_SHA256 in config fragment
- [Low] selftests/ipe: keyctl id check precedes already-provisioned keyring=
 check
--

commit 0116188a11e090ec7a12ebe17082312fda668a18
Author: Manuel Huber <manuelh@nvidia.com>

selftests/ipe: test the IPE policy keyring

This commit adds a kselftest script and configuration fragment to validate
IPE policy keyring operations for both sealed and unsealed boot parameter
states.

> diff --git a/tools/testing/selftests/ipe/config b/tools/testing/selftests=
/ipe/config
> new file mode 100644
> index 0000000000000..498c224d2c182
> --- /dev/null
> +++ b/tools/testing/selftests/ipe/config
> @@ -0,0 +1,7 @@
> +CONFIG_AUDIT=3Dy
> +CONFIG_AUDITSYSCALL=3Dy
> +CONFIG_KEYS=3Dy
> +CONFIG_PROC_FS=3Dy
> +CONFIG_SECURITY=3Dy
> +CONFIG_SECURITYFS=3Dy
> +CONFIG_SECURITY_IPE=3Dy

[Severity: Medium]
Should this config fragment also include CONFIG_CRYPTO_SHA256=3Dy (along wi=
th
CONFIG_NET=3Dy and CONFIG_SYSFS=3Dy, which CONFIG_AUDIT and CONFIG_SECURITY
depend on)?

In test-ipe-keyring.sh, generate_keypair() and sign_policy() generate
RSA-2048 X.509 certificates and PKCS#7 signatures using SHA-256. When a
signed policy is written to /sys/kernel/security/ipe/new_policy,
new_policy() -> ipe_new_policy() -> verify_pkcs7_signature() ->
pkcs7_verify() -> pkcs7_digest() allocates the shash algorithm:

crypto/asymmetric_keys/pkcs7_verify.c:pkcs7_digest() {
	...
	tfm =3D crypto_alloc_shash(sinfo->sig->hash_algo, 0, 0);
	if (IS_ERR(tfm))
		return (PTR_ERR(tfm) =3D=3D -ENOENT) ? -ENOPKG : PTR_ERR(tfm);
	...
}

Although CONFIG_SECURITY_IPE selects CONFIG_CRYPTO_LIB_SHA256,
CONFIG_PKCS7_MESSAGE_PARSER, and CONFIG_SYSTEM_DATA_VERIFICATION, none of
those select CONFIG_CRYPTO_SHA256 to register the "sha256" crypto_shash
algorithm.

Without CONFIG_CRYPTO_SHA256=3Dy, pkcs7_digest() returns -ENOPKG. That caus=
es
positive policy loads in test_unsealed_keyring() to fail, and causes the
negative checks in test_sealed_keyring() and test_unsealed_keyring() to
falsely pass before ipe_new_policy() ever reaches ipe_keyring_lookup():

security/ipe/policy.c:ipe_new_policy() {
	...
		if (rc =3D=3D -ENOKEY || rc =3D=3D -EKEYREJECTED) {
			keyring =3D ipe_keyring_lookup();
			if (keyring)
				rc =3D verify_pkcs7_signature(NULL, 0, new->pkcs7,
							    pkcs7len, keyring,
							    VERIFYING_UNSPECIFIED_SIGNATURE,
							    set_pkcs7_data, new);
		}
	...
}

> diff --git a/tools/testing/selftests/ipe/test-ipe-keyring.sh b/tools/test=
ing/selftests/ipe/test-ipe-keyring.sh
> new file mode 100755
> index 0000000000000..557ccc825fe24
> --- /dev/null
> +++ b/tools/testing/selftests/ipe/test-ipe-keyring.sh

[ ... ]

> +	keyctl setperm "$KEY_SPEC_IPE_KEYRING" \
> +		"$IPE_KEYRING_PERM_LOCKED" >/dev/null 2>&1 ||
> +		fail "drop mutation permissions from the keyring"
> +	ktap_test_pass "mutation permissions can be dropped"
> +
> +	if keyctl id "$KEY_SPEC_IPE_KEYRING" >/dev/null 2>&1; then
> +		fail "the special key ID granted possession rights"
> +	fi
> +	ktap_test_pass "the special key ID grants no possession rights"

[ ... ]

> +keyring_serial=3D$(keyctl id "$KEY_SPEC_IPE_KEYRING" 2>/dev/null) ||
> +	skip "KEY_SPEC_IPE_KEYRING does not resolve"
> +keyring_description=3D$(keyctl describe "$keyring_serial" 2>/dev/null) ||
> +	skip "cannot describe the IPE keyring"
> +case "$keyring_description" in
> +	*"keyring: .ipe") ;;
> +	*) skip "KEY_SPEC_IPE_KEYRING resolved to an unexpected key" ;;
> +esac
> +
> +keyring_unsealed=3D$(cat /sys/module/ipe/parameters/keyring_unsealed)
> +case "$keyring_unsealed" in
> +	Y)
> +		[ "$(keyring_key_count)" =3D 0 ] ||
> +			skip "the IPE keyring has already been provisioned"
> +		test_unsealed_keyring
> +		;;

[Severity: Low]
Can the "the IPE keyring has already been provisioned" skip check be
reached if the keyring was already provisioned and locked?

When the keyring is locked with IPE_KEYRING_PERM_LOCKED (0x08030000),
KEY_USR_SEARCH is dropped. Because lookup_user_key() returns an unpossessed
key reference for KEY_SPEC_IPE_KEYRING, running keyctl id on
KEY_SPEC_IPE_KEYRING fails with -EACCES once locked (as verified in
test_unsealed_keyring() above).

When test-ipe-keyring.sh is run a second time or on a system where the
keyring was already provisioned and locked, the initial keyctl id check at
the top of the script will fail and skip with "KEY_SPEC_IPE_KEYRING does
not resolve" before reaching the keyring_key_count() check (which uses
keyctl list and only needs read/view permissions). Should the
keyring_key_count() check happen before calling keyctl id when
keyring_unsealed is Y?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-b4-ipe-key=
ring-rfc-v1-0-156f0b93e843@nvidia.com?part=3D4
