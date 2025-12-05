Received: from smtp-outbound7.duck.com (smtp-outbound7.duck.com [20.67.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DC3176FD
	for <linux-security-module@vger.kernel.org>; Fri,  5 Dec 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.67.222.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938133; cv=none; b=Pj7gXya+HOkW8eSetxTAxrTpo2b7wmTmZnaMdJJO6K7Z9eBmfoIqieFhtr04EuCEqqbKxOd9itFeL8ZVdldAKEnWjEGLV/x6ZCnFSs21cYbof/GZ246c2EHYc3ml9wIeytzF7m22WGntLVOe15BfUtEHEO65DDKYGlF2sSgFuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938133; c=relaxed/simple;
	bh=Hx3WVft33VG5sni4+hebJOysxL8mSnognrrBb4rEePM=;
	h=Subject:References:MIME-Version:Content-Type:To:Cc:Message-ID:
	 Date:From; b=crOKgeeD/VmavBOnZZNrJH9mMYAlpcIt419DqJSOnKhJYsT7dIGMqlGjRHm2Vqd/5fXn2mwtiXJxAnOraoM1Z4/iYFPO4N1qFPYsnt6mVM/1XGMlVzf8O270bGZmvFt7SGya6x4u+01h7HVscPx8oDzLU+gJFDkZyyo0mR54USg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=T6FNl+5H; arc=none smtp.client-ip=20.67.222.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duck.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="T6FNl+5H"
Subject: Re: [oss-security] Island: Sandboxing tool powered by Landlock
References: <20251205.saiZ2Pauleew@digikod.net> <303DA753-37EF-4530-AA63-4C3579E9A454.1@smtp-inbound1.duck.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Bar: -
X-Rspamd-Report: DMARC_POLICY_ALLOW(-0.5) R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2)
X-Rspamd-Score: -1
X-Rspamd-Action: no action
To: "oss-security@lists.openwall.com" <oss-security@lists.openwall.com>
Cc: "landlock@lists.linux.dev" <landlock@lists.linux.dev>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "lwn@lwn.net" <lwn@lwn.net>
Received: by smtp-inbound1.duck.com; Fri, 05 Dec 2025 07:35:29 -0500
Message-ID: <EA19FE16-EB55-4DF0-8F53-04C2B83EA2E6.1@smtp-inbound1.duck.com>
Date: Fri, 05 Dec 2025 07:35:29 -0500
From: kf503bla@duck.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com; h=From:
 Date: Message-ID: Cc: To: Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1764938129; bh=Hx3WVft33VG5sni4+hebJOysxL8mSnognrrBb4rEePM=;
 b=T6FNl+5H/khTbCqgtgcyaGFHHG6UjSslO2uQ9kRPRUOBYzUnrPQFWGck0nO9erf6CsGvA74UJ
 FrYimahGawclwNjPd9owXRokzjXNYThgg/2eBpO+h1lJpdvEqiBQgGlWW+W+BnO2fpnrwxG4xX8
 w8eQuOs2bu6q4syfCLl99yA=

Why would you publish it on github? Please consider codeberg or src hut.




Sent with Proton Mail secure email.

On Friday, December 5th, 2025 at 5:14 PM, Micka=C3=ABl Sala=C3=BCn =
<mic_at_digikod.net_kf503bla@duck.com> wrote:

>=20
>=20
> Hi,
>=20
> I just released Island, a sandboxing tool powered by Landlock:
> https://github.com/landlock-lsm/island
>=20
> Island makes Landlock practical for everyday workflows by acting as a
> high-level wrapper and policy manager. Developed alongside the kernel
> feature and its Rust libraries, it bridges the gap between raw security
> mechanisms and user activity through:
> - Zero-code integration: Runs existing binaries without modification.
> - Declarative policies: Uses TOML profiles instead of code-based rules.
> - Context-aware activation: Automatically applies security profiles
> based on your current working directory.
> - Full environment isolation: Manages isolated workspaces (XDG
> directories, TMPDIR) in addition to access control.
> - Transparent shell integration: Automatically sandboxes commands in
> your shell without changing your workflow.
> - Zero-privilege operation: No root access or special capabilities
> required.
> - Layered protection: Multiple profiles compose cleanly with
> deterministic ordering.
>=20
> It's a work in progress, so be careful.
>=20
> Feedback welcome!
>=20
> Regards,
> Micka=C3=ABl

