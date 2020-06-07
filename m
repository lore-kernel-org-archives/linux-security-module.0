Return-Path: <SRS0=lXmD=7U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17408C433DF
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jun 2020 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E833E2067B
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jun 2020 23:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ABlBM4P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFGXdg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 7 Jun 2020 19:33:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgFGXdf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 7 Jun 2020 19:33:35 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8F40A20B71CC;
        Sun,  7 Jun 2020 16:33:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F40A20B71CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591572814;
        bh=qqLM5q0pqz0yfc3O++Tr6hw7BmJ7c10HldflmnR0q10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABlBM4P784LLcJRDNr8OnWTm3BQ50AkH9FQVDvh+/fOXjneDNKHeC+y4VhphakRUO
         8+7rjsxxpkWY1bs6/Xp0CUnQ70qskcDEe9/8PJEgWp0BFxgYSNKdzcEsDp3q8rbv6p
         YaN0VLnHeMjc6sSto9pNWodp9ZGhNmPTlAbG98no=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [v1 PATCH 2/2] Add Documentation regarding the ima-kexec-buffer node in the chosen node documentation
Date:   Sun,  7 Jun 2020 16:33:23 -0700
Message-Id: <20200607233323.22375-3-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200607233323.22375-1-prsriva@linux.microsoft.com>
References: <20200607233323.22375-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add Documentation regarding the ima-kexec-buffer node in
 the chosen node documentation
 
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
---
 Documentation/devicetree/bindings/chosen.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..a15f70c007ef 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -135,3 +135,20 @@ e.g.
 		linux,initrd-end = <0x82800000>;
 	};
 };
+
+linux,ima-kexec-buffer
+----------------------
+
+This property(currently used by powerpc, arm64) holds the memory range,
+the address and the size, of the IMA measurement logs that are being carried
+over to the kexec session.
+
+/ {
+	chosen {
+		linux,ima-kexec-buffer = <0x9 0x82000000 0x0 0x00008000>;
+	};
+};
+
+This porperty does not represent real hardware, but the memory allocated for
+carrying the IMA measurement logs. The address and the suze are expressed in
+#address-cells and #size-cells, respectively of the root node.
-- 
2.25.1

