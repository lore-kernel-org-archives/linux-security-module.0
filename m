Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019952;
	b=YHz3XVM1ZKnKs2iZ/KC8pFni4JaUbdVsIksg6sRTpvytAmo2vC0d8NvGLqbWIMrmUKYP
	 mYlBVmBftKq/aqtV5VqaGHVK1yg1WmH55W+iTX5mcxlZS41AtmV7I6x7vfeJ2frWtZosM
	 qblb4I/A9d/ounVAPM112oC4G2IX32NG11cEzkw/NddGSzfwyKWP3y9ZFR7MdUTLdlCZe
	 jHdi7IeHSDrzVQTiSVQOYO4nld/DeRPLCv/ciw0jWUZTitDgEbkgg/guWcd4jdCuy+BhR
	 GoVsmcrE5fjNBKDZP02eYgskWcJ6ij4Am5adhcJ1rGs+g9/N6jkMyYRZWEawzEgAayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019952;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JdMwO4o/YW2yLXno/fQ6dnChRRXKEIJuepNS4m5gCBI=;
	b=MKWAQ+Ui8xvEmoyQSk4Y2ziwY3w/lRIOF4+WFr+y8IlJ/qmaFL0RgzO2VRnC+kUhMiVq
	 clzKED2sYUj+g0rw7AUVn7aUYmyq0LRfnXTfdK4B+ftD/6fl6uma5CC22bFWGwGgVNa0s
	 DrA7T4m6Mtq04oTL+B8gsiU4Qh11u2r7rNpZx47JE2XoNi7o0pZLg5XOmF97dDUE3BYJs
	 mstgp2OSRkBNiIeWvPbSVbOEKHYEvfwQrG+/ktDL5rxmtzsIdaVFnjmxPxDjHcXDhYCSU
	 QNRgoFdWylJ0ZU7zt56TIAlvc2WuvkJ8cxA1AgEChUlFgjfq1gVaUmtejUzYKzH+8sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+af+LmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109F606A32C;
	Wed, 18 Nov 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+af+LmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FAF1F000C5;
	Wed, 18 Nov 2026 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019952;
	bh=JdMwO4o/YW2yLXno/fQ6dnChRRXKEIJuepNS4m5gCBI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=G+af+LmODsRQ478q2lXye+FhAeE2t1Cm93Cr1J54WU6HmaI99W8G1Qh1kLC1kYgOh
	 basEHRbDMa63Mc9k4fwCV8qg6QuLk/in7mvcyk/T8p06efWDuYKZDGtoaGNNgIpkNg
	 rsBFiC31v2Hgj6Zs5lDOb2QxBD7j2R3y6aXNB5IN9nByhBbJ+QTxZdUZn2PeO5Rsf1
	 wiQl10wqJAwUpxIcJLFoZ0KgA6RBkdwTqhf3GGv7vZ5e9AmHry1F4qsHW2SkWXbiMY
	 k5LQQMTTO0VOC42PlOQyl/eEj/PaTjz+XJYo/t2JRM6yBfoA0jE72Jh1HqhuwNDqE0
	 nF8iWq1Ktjz+A==
Message-ID: <sashiko-outbox-221517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] landlock: Document namespace denial operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261118163254.2554413-5-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
 <20261118163254.2554413-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:39:11 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Namespace denial records now distinguish creation from entry.  Document
> the namespace_op field in the audit and trace references, and clarify
> that it describes the semantic namespace hook rather than exact syscall
> provenance.
>=20
> Creation reports the ID allocated for a namespace that never becomes
> reachable, whereas entry reports the existing target ID.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118163254.2554=
413-1-mic@digikod.net?part=3D4

