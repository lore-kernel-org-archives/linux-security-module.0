Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E03ABD8F
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325188; cv=none; b=rUSW3wXy3gVgvosg1phJE455sgjgSXL7OpzNy+87+DbzVpDDXNDx1YeqrxjM3ZEA1nMYcwx2CygifJ7ffcoKSo2QC+0iRhdA0Fan8nl49LZQ6EFwnu1PPD/1EYdBVUva6ot2Uu3eqYtkptMxZkCBjFtHL2em7NHfW9vRUfhuk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325188; c=relaxed/simple;
	bh=VxYGnEtGhyOhMuEu8IYBGok3vuvafGNIJC1WzccDIrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YekjB9nEm4uIMHyIPB+FnwYj0idkFPPEF7XGFgWM2SNgCy5x9/NiVri0u6mq6QOpCyV4VBHBOB9k5vx6iXzm4wO8NT3okj98hBWT15oWhePLEdL5w2uLChtk4YWKvP8w3il39MYm2E2554BJ3quhwOWQfiyhytuBK5CFZU7oPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RExf8XW1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RExf8XW1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efcef23d21so81913116d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784325179; x=1784929979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTHnI4tk14VzICrnAviLiJ+u/Jb8//xlr1zZxSSEVZ4=;
        b=RExf8XW1QRp3NMLJiXvnty5rCtdEQ4ILTCjbDXpiGmRvb4UtkHXwSXAhWboZjpwqYq
         3TKfF5svgtluI4XEQIumUcSWub7bDerKovW2Bk7I6ErXF5GHf/hQA92Zv0U3L3dxdRjF
         YRnJm9+TTEIeH+fMNM/gA8AtZsgHqTAmRRNsEvveePODPAR/42/Vc1r3ZmPPyr+0C0w/
         Bd9kmQdSbxURdYeIMLKYD2dJf6W5E/xq+x+YJsz1rQkF08Y84RN1l/ulVs5W7yMBGz4Q
         AYl0hjWexQB9+o/AU3gxecbHpIwpTDDakEisK5mK3cz/5WmI7wW6givAnQCRuYqONkiA
         aWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325179; x=1784929979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTHnI4tk14VzICrnAviLiJ+u/Jb8//xlr1zZxSSEVZ4=;
        b=p45WgRH/Ry4DdCKp57NhXsfsycuwOCvkjLSglHF5Ab+ANbeaR5vWj13MhJRzYXxkbp
         KWToYpZMq1C3zIW+MAviyP8WL8NpLNw9AFVBSrZPZ37tKZdeXPY9JRcXfbeesy9Fhbr7
         aMyM+Om81T9i1LWi8wtyLGfbnbd8kMY9nJ99tiU8mTLtSvP19p1HEyk/7TIsSTVsNQ6S
         QsCJu6jL/1weG+lds4YqosRYihRvJ+RnRFWLoQlniBGlBjhUKGW1OqsScEZ4P37A4HSq
         FWu1X/CM9Eigdh7UtxtT2N/WNxevC0GKIn2/DGPMrxM0M1Zt63e0EHmQBlY9J6TB7Bdq
         jpMA==
X-Gm-Message-State: AOJu0YxXNcec0wPnA50ejcpO/nqr0ExntaIx8VfHCCUORLgyql7ij1Ra
	Uaz81pOaZgSzDLRrPp7LqsF7jOs+IiW7TQ/pMOJ1FScjwqcmUtS2Lcrw2QNbuMdXVmkzVere1U8
	GHT8Wtw==
X-Gm-Gg: AfdE7cnTEPeMsK50AgeXk/CkYcbcbnEiCAHGAWq69ulF2kU7tL0dKyQH+E7Pl29m271
	s0YqJLHUmudGbwB+BfcUz9lK0V6hHs95S4Iu9MCF5178GUdbEVvaZoxrnCpimOcMv4jKlivUovo
	cAET+BtxUt4viiUkrJICITs1mAKidojJM41GUc22WnumQHFPBTvGVEAFBV7gY/MP18lpBwWmfv4
	IKvUxmpqcb+chIm5P++6Ef5y59+oEVu3otd8AxKa6LfLlqu7dYylqFwQpOd1KMm0BK8MRgLp6fV
	sdGUft9bx4Qsg4DqrCNTaC70iVxlGUcc6neuAs7QBALOj96w/0wXLKwyIZxUxjS5IIT9R3MY4YT
	NPoAG0RFhw76WQVGbev90GmjIERlD9i/zaGF+VA0DajSaRnO3bTDke6n+eLISmkGaDROgJsqXYp
	Ne2Bt0SNryIncb5HaSRGI6uVnABPzm+hiT5MRN7JUqGBj024u3Xd00AaFsbw==
X-Received: by 2002:a05:620a:4614:b0:92e:8aed:4785 with SMTP id af79cd13be357-930b3ea9c3fmr498122385a.25.1784325179114;
        Fri, 17 Jul 2026 14:52:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b54773fbsm252390785a.39.2026.07.17.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:52:58 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>
Subject: [PATCH] apparmor: leverage audit_log_n_untrustedstring() when possible
Date: Fri, 17 Jul 2026 17:52:55 -0400
Message-ID: <20260717215254.383183-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=paul@paul-moore.com; h=from:subject; bh=VxYGnEtGhyOhMuEu8IYBGok3vuvafGNIJC1WzccDIrg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqWqQ2eEy3npq9yixn9J6Ci2FUGHcmPcprbS0Uk MX53KrVWj6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCalqkNgAKCRDqIPLalzeJ cwFcEADavWoARyvIk5XHg9ff0t8BAxu9ORIPa0lBPcKYBg4S6fewDxG+8MK46aeD+NmwckWgBBT DfdfRLLElKTk6gtvIUV2qxOLaKawtYDQ2schozXaAUx6yJvW+ergSiNJRJZzJ3kjA6az2BgmQvD DEWZUsUyKh1asyggVBmFsLTOYETn24lWojz8jaVJIz+R+mg+9Deo3oY0i4+s/zDiJ20l79OC4Tk 3EnADVbiQGEu3Ao71PV3OYi6XpIOpsjxot8+AAmcjjraQYoM/tbZrO+JO7a9W9UCcncpmogzwBq 2ubBQZR4GSYp1l/Lo+i+5LD5UbQ3ZLk7O1KsmJYGOsmDq5JdPKmn78DVdueDjD+d9pylOjc+1hk Yx4IDOmBkptRlmu3qMiDTWU7Zmxy6kyT1+tEGmliisRnBPUIrxyXG0dMzCgf5Sro20boa4wyw+w I71qZqtOiZAz2PRUQFUaXYECZEAwD+uvbTNjaYIa34d6BeiBYbFnoEAGy2wwqFjoO8jJoxI8xfm H18kFyNbHHoG/BNHhdlJ+HHXgiJbREL7Juze4AB3e2H9uFGHk7yi35pgm9XRWgGT4ONGrZgTjAO q1ejn4rYTZ+mkWlKon3j3RjcU4M+rtlklOmOWh2oltXJtOIyWMLLwFArWF8Isbfu7A1EaHH7bL5 wpPd6hqS8NnHN7Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Make use of the audit_log_n_untrustedstring() function to simplify the
code in aa_label_xaudit().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/label.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 3fd384d8c41a..a165cadf8249 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1743,10 +1743,7 @@ void aa_label_xaudit(struct audit_buffer *ab, struct aa_ns *ns,
 		str = (char *) label->hname;
 		len = strlen(str);
 	}
-	if (audit_string_contains_control(str, len))
-		audit_log_n_hex(ab, str, len);
-	else
-		audit_log_n_string(ab, str, len);
+	audit_log_n_untrustedstring(ab, str, len);
 
 	kfree(name);
 }
-- 
2.55.0

