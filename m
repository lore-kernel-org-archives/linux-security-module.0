Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202770;
	b=4DZswG7+2iyX+GWeu6LUS6Mhx1+h6hF20+buDA/KRQ/G5azsndjd26XMoaMUNumy6s0s
	 0b61o8UbIwlqOe1KiCb6bDoXCyun83nEnDieejQASqn9AZCtVP79ZYOpqwAQAavB/7EPD
	 jKI5IaiiAgK0PFDBafkiGDu6LpJ/ciLBylObeI+49qG9cD3qXR/ThXGiDjVQ5Zk8sZmdG
	 R33CbpJnAKjpaW8AN75FVrPbYKz0iwSGDrOdAVfCBuVClMC2aEbLN5lm/QyKgYb24IQBO
	 AzkWMrOmFzYrPfflGNFuqtp+dSQ9Dgihp++tJUZxJg6hXrAdIsnTtwbgAIqrGAa/48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mailer;
	bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
	b=Ng/vEaGTCXpnjF7amiHxECbv++Afvyoi43AOkieF/5ywO8Dz5jBfpZaIgH6zsqjyN15d
	 QZ1PuWUnGIAiKJipfPSkcFCZyDfsanxs5GGsW/QxMsoO0yBom8XaFjxCBvvuOIbCkul4e
	 WDEs457+H6/Qeue4lOsS2sTA6SL36NpcEmp1xGsvM/LL3L1Cy9OP1msTbeYnXB1r4DcDU
	 pmqcc9cuTxKWhH9Tjdn7C7wM4om1er99qazTN5OLNUkVKzto8WxHzGwbTqXKjfpzcaGMK
	 cEVeOkT7uXe+z19bldEgJVpM1DTyB6d6YftVkbAUj/FL+Hz9HWppfgiFl9hxznLiuzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/c396Cw";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B70606A31C
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 05:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/c396Cw
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4910b863b84so278910f8f.0
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 21:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202769; x=1794807569; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
        b=m/c396CwshKMa2EHH+DQktTUWKdT+G4FYhJZRO1ZyIRIhcH4JLYWrzEMYp+ItdlBIA
         TfrpaAz5zE0hxf52AhEiwplZI2VXfKYLCOe+FYHpU03rM56D8UVCIbC4EkcKucUXujME
         UqLm9dyYq2Pd28HnP+Gy67SC8ArUdRCZcomkUowXHVNoiFIICmBTIVdlsiscdGA64vyO
         RBLD8ILK91ZHqy91P5VTxFDBpvH+IqxaQ1CA0lQRBHmprYuUvpkUhVStr1VvYNw7G1dZ
         nYRFBFec5K4S/6FdpKhkVPUYrgzt6s8D/Fsckxa/yVxaOe5ssdJEt9lk6iqQknhDSoKJ
         IOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202769; x=1794807569;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
        b=ggjq1uyoFvbEMXdpULnzQj7g0juNwk9ryEiTdWyBsX6wBB9xWcqxedPajaUqcQFR+D
         mjKPASZjUf4hy3yZa8pUT3C0qgX+xeKs9nPP+8AvF5RYVxRAQ987KxMj80UNFLNBEgSp
         6qWQzvcKPw0xk3rfvD8kR/y8zBrmlXKdmuDo4qaRFm/ItbzTgVnq+1xAbze5CrEb6ayG
         9fHIuPQid9JiQCRvZIK5R9PhIHYqwamWPjrdCIWyMaam91Z0ha9MFoJzSWiddjOQ9dac
         DmeAsQeqdUH/KgXd6U3KxdP7PagSTiEC4iCt9goLK05B1xnetXc8cev79s/CGVbIdIXh
         e0yQ==
X-Forwarded-Encrypted: i=1; AL+hErE2z27miNdNEUg6tJwSoxJLvPH38PIUfNp43cgYQoxSvFZRFWsPZ0lQgT3KoWd0gEqSJejds5Y3xqCHF34ylbt+kcvwr44=@vger.kernel.org
X-Gm-Message-State: APuU4Z964Q1Xq24khMjxpXmJEZQemVrelm+y1Sn8t4qjFizWA98p4C72
	v/mOn3/5NgIPDIGfs7al1oNfpdKZ2E0mBW2H9RkBhepqXZehdZrpz6wX
X-Gm-Gg: AYBFou3DIenxweh2/WutOcTaL0V17kGK8ta5+z+i3KQu7ft7tE+4V9uMmfh4Ije6pJc
	3IVsCySgMuNHcEN1UQV3CcPdd4dts/odrr+BPNme93cbQ6barpECxaObN2QbEIzM87d/r1UP/q7
	yekfy8p2yr+iotOKIhReZQbRavI6xQjRSf5KAY+glRPPvBg6jsd9iaktycCdsNi6YLhM5yb6UV0
	rvMM8OhjJ11XqO79lq9ENptrV2YiZojC0Gbn6llkDB4BK5O4R7Z6x0XIXfnNNhD7j2wR/bABz2o
	timQjjLeCQVq321lzXWCfUNfi9JBDgISFmwYluX9TXE618OIo77TtiY/zXdjFP5sOgdx8MehJNb
	9ejLqgjiv4g5SVCI9BtV/MeNjKi4PMiDrA/8mbAFgs88j2xMQxpdq4bdqRDzRZfETXdGf6xRU5+
	43vBks2iOOU1pwAoRABxuo57wxul5/ErP9uLPD3dNHXWC5l7n7ILMeLCE1Gh2dP4vxXd5Iz9UVy
	aFVhI33MwIsq1YEVLP8JLfBI2ElG1uSnORPs0j/CurZ7SN3PAiCYMNVmULU8WVa/+HJ96WsJnSJ
	V/yca9u064wLCF9rdclyWbvvygtnamy/gWmMHsrxTKgrYb9VbH6c5/ACbIEK/eF7q7e0SPNI6SX
	n5N43n5IfrBacCo1BnAizWiNtMJhuqvuqdTpKETqycQOfDa+fEktiko7M1fMs0IsYNA==
X-Received: by 2002:a05:6000:250a:b0:48e:d40:a87c with SMTP id ffacd0b85a97d-49423997d63mr12864728f8f.16.1794202768807;
        Sun, 08 Nov 2026 21:39:28 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967a70a35dsm4750189f8f.9.2026.11.08.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:39:27 -0800 (PST)
Date: Mon, 9 Nov 2026 08:39:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avFcjHwnh9mrOEnz@stanley.mountain>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
to avoid a conflict.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 30188a0ec676..2d6cc53539c8 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			       asn1_oid_len(tpm2key_oid));
 
 	if (private->blobauth_len == 0) {
-		unsigned char bool[3], *w = bool;
+		unsigned char boolean[3], *w = boolean;
 		/* tag 0 is emptyAuth */
-		w = asn1_encode_boolean(w, w + sizeof(bool), true);
+		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
 		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
 			return PTR_ERR(w);
 
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
 	}
 
 	/*
-- 
2.53.0

