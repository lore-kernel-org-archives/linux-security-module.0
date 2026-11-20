Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171475;
	b=simIaG2PgeXw0DNF6AzhVt9v+hU34w3xXV92pfjsVL5EhgrGgG4WhwUpIU9qaH4R2+6x
	 PmwKctk4jE5OLLZy99HedxTDclUFc+mwdjxU7LOc/YDceONeLcQpi6Dm/VHB194H8kRfT
	 0WQPenqM90utOB0AfNrIMuInEzO6q6G3bR6ireKYaUjPggZd7oiGA293rclTdDHEeaN4u
	 HLPONUCzN1KrbpN9/jfPo8HcSgJ6/rstbQ2fsy0d3Awcv5ZyG/pFjtF7Ah8xiN2A6Br7G
	 ly7YpWe2qCZIKN7Idl1qyGgP/k4s6Y2eTeqO2trAn4VVe9woUT71n2Gp3Phz73GtUfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171475;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JsqpgB0A0PresyEEYoyd/ZHrKXAzvTpJERbRBZY84Kw=;
	b=5gEpvTyvUDuYp0Rq6t/Ax/rHoNEcDG2Xfmr6TuJnpGg6FWmmLy/ONt1fOeTQ1TJxDcGm
	 3aVuhPbNVNg7XAEHAedOMuX+Tt3bliGoPoJu+HvF6SyXUYbBpZevqVbk0CGQJF7MyvSpa
	 B+H/1JFY6fjDjgJ8BUy+i5BhtNRstGadCRB1l6dmQgkWc0SS/HipNLaMYV4q1kwH2inJx
	 X7nr6lnFdu1uSJLeYKrrVDZrCsO2uslGC0QIcihuW0APSQTeLo+OuP/Gqi8hOCfxEBYWm
	 M6CM3siU+1cgXM0x5+bqNDh6VDhL2ZhDFfSsqIZaZSKpHVRDN2VCD+UAI32x40F+pHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoJrroKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CC606A334;
	Fri, 20 Nov 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoJrroKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196661F000C4;
	Fri, 20 Nov 2026 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171475;
	bh=JsqpgB0A0PresyEEYoyd/ZHrKXAzvTpJERbRBZY84Kw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PoJrroKu3NNp0SbpMJA2F2IMgBikRoZ3HL9HMDxk0nW10ZLVh7jmaDV2RMujul8wY
	 TSB5WK5A4O4yc8kAz+PZQwyAJctoyRSd4tVes0zTVSolz1e7MGalFH7WlE3hdiRqk4
	 JAjOYnk4yfOQNvRpEIVwG5vCLpSE63gOoo8T31KeEVunSHiZ9zE5p4qTLC0st5Py7e
	 YahYd3cyxoCHD9kdbnx8iyn63VszX4wJOb/QBdVUZuwwJhYMlfFhkPXVVHu494s56G
	 wGdKNKPFxmtdK53HzC5sz2TaiO0NZezLNMlKdJWmXas/vhGAEeSQblhSISO1Ybd8fb
	 62f3uF/Ha/dxw==
Content-Type: multipart/mixed; boundary="===============8787224294258530798=="
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0df319dfcd7e3797886c1bfa092cc986e1caf8922450cea44d8c4a38ec6d8adf@mail.kernel.org>
In-Reply-To: <20261120094820.11929-2-tasos.papagiannnis@gmail.com>
References: <20261120094820.11929-2-tasos.papagiannnis@gmail.com>
Subject: Re: [RFC PATCH 1/2] security: Add hook for unresolved pathname opens
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,eddyz87@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 10:44:33 +0000 (UTC)

--===============8787224294258530798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> security: Add hook for unresolved pathname opens

TL;DR: Commit message only: it lists what the new file_open_name LSM hook
changes but not why it is needed, what existing hooks can't enforce, or which
LSM will use it.

> security: Add hook for unresolved pathname opens
>
> Check the copied pathname against the selected base before traversal or
> file changes, including O_PATH and O_TMPFILE.
> Pass lookup flags so policy can request a referenced retry. Recheck the
> base after each restart and cover kernel opens with an explicit root.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

This isn't a bug, but could the changelog say why a pre-lookup pathname hook
is needed, meaning what security_file_open(), security_inode_permission() and
the path hooks cannot enforce, and which LSM is expected to use it?

Each sentence currently lists what the patch changes (the call in
path_init(), the lookup_flags argument, the recheck on each path_openat()
retry, the ND_ROOT_PRESET case), but the problem being solved is not stated.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44717653250
--===============8787224294258530798==--
