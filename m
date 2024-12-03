Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CF1F76BE
	for <linux-security-module@vger.kernel.org>; Tue,  3 Dec 2024 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255376; cv=none; b=Ew4vh4lWW8EP+I4ozK6JEcL5gRUg4VLljkKU+hJfQ41EJWIZj6eh5eOkdpS6H+FB3NqcB/HRT4GFyfGCyhs5FD9fxHSZPUdwr0YHEcspAtDRAtA8Z/7R/ypdmWSDVpuoHk8KMAOahvCXAJS2HLoiwghG7vVMjRWjv5Z5yTiHkk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255376; c=relaxed/simple;
	bh=1hhAoBvrf9N7IbOa5cmyJLA7EmkasAR4g3qIUHqoE/4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=CZrXjZY7L7/7QTxTLceoE3Zv3xyUYlnYXy0VyLoqoGg1HJZIu1HtyavtM/ZCbcJ7FejQyRdGcCxOGhxUc2ogU9ViYYfrdWglPOjekrvcqNiXmweJ362cExcVYZ+RW9dXgJjVtgmBjSOtYgmkc7QuZyozE6zwxVOs5HarLVdRpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FTZCt/8Q; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FTZCt/8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733255373; bh=1hhAoBvrf9N7IbOa5cmyJLA7EmkasAR4g3qIUHqoE/4=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=FTZCt/8QsZORLJiGzl/MVAYHniDducJBmzV8+gK53l16Kz1D9x8eY9EeidIu8uVGTLnm4wvCX4fhmhKadRk2NnGkbq7utkxfkQWzSimfmgUSMCj1wxeN3rmNo9RMxgVSXjGtwbcpycB6mlQXRIClw8YlcDZir6wJk1fhFVcJxqW8JfHBxa89HN/qmcQhcQoc/Y5VM19RP1U6ELjOfUd0yl1c63FEyc6LVlcZPUv73QmxmGDuIdacpJwQztBnal7ogPBl3BJgn21/lozwe8EQ5V/lIgklqVfk03xnjmU9YAamHrmlUYnOaSL8Bo4DeuHF38MxK9NjJdPbEU1KVIaoYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733255373; bh=Rd0IIYaymaz/9203tQytWNaB4yQa+9xmksTruwNDeJg=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=pRXoWyrm2NCxlgs6cxGVKY3tsrsXVCbcXj6NXBToBmcV6vluLF3WnxyS+JOhFPqn7ntqQcnSQb3URCjA6IyhiIYf2BmciRZRw8+81P6sJHfGSqCSaYmUu+Ikt7k3NoVstqBztS9TIrOS9RldC5hGigzgsLrpw5S/3lVmIT1wfiAK+H7NSgTOXDmoI2UaNNts/8sQQoY6ec8RCKr36BMH3H/Fk+JJgxFv3b+JkPu49JSdRTA8535JTEC87HglbOQmr1RHYmLw+GNf7+pDuH3IQwPi/InFo0xBjcuGcYy0v+3CY6QD5LSAmIsOM4iBDlrgohbu8lpHD7JqL2RvPfAntw==
X-YMail-OSG: RFd6zMUVM1mESMltGW3BTMNYkeBASvqqQq3QRymBwIlhvKMpOY4t2_ZKonIcDBG
 H1Dpf7X16gm8fTwSZ66V60XZWtBk5SXzahiAC5uorExuSrmspiYvVXlvkx0KdgflezpjaXNW_9vo
 wLdPnTNt0JY.ynwvUmX2GyMCI0ftrE_ID1EwGyFHjfZYj9xWobBrJFYMSfuEPyKQB3_2TpNfrMwy
 aFPnQ01zDuLOtGZbsHwefikimHFOzTwdODlkWSprYUaCdCaXEJidNEJOH9MZeZtcKrTCC5wbXMpY
 gBro_DsvWdgB7_XQetN3VqVcZbhQxK1lh0pGVlntRdEV3PsBe8TFijAasr48FuBzVghpORjtvZbJ
 lWX2LdRnDhfeYV7Q9tAZVaI4oBcRws9XCKun_g7J_2Ye8HannurE3iBvGL8vKadiH05.B73MmK2L
 RwpFRVe0XBX.fEkJFSq3c6T.aexRLpPi.gzL2hX5Bul.OIgNraEWnNpGuwNnM9H2EosRmsvA.4Pp
 fJwxpjvYT710mUlWdQ0OyJkRMqGs0tfa3j38lgvPBhSv.elj_VujPT0Iejz43Oj6Q.HIAjQ0wRyp
 DuL1Alrx8EIeE1HOsNh2HQXSIxT5b_tT66C6F.vfVrbSxmRVFP4XKVDg9hmVoA61R6HbIc9P5XJU
 f3cNlxhXo5cDepWNZ.yKIkb_yUuIfTY9mt8bsHIZdxTgcDFeOrB2P54P86N5MCcEomkCD20R0Acv
 KhZWhaG.XtmYJARHYf_vmzWw5s5SK5Lnk9wxbQwXFsdMg3U6EHTlt0jbTM9ywCrsBWJXMb2AJxtm
 hUHk1KIeHmdG0ns3j2k6CsAx1igI_YbC6QIZtoXMcrBj.GFj9WY1OKtr.GgBNMMeK2KAwyDUltj0
 MFjZPsNclcBoIwVRI2KbT2PGmuZxoKebbKbowb1wUP7gTcvGMHaB5Z2_oJDgSvs9VC.D7Rf.13eY
 TdLJv3iQcrSs_q8sabRlZzgVDx1txqYQ_a31LlDePOsAIOsMbidCnA9DBh7Vb6mlt_TRmMeW3u4O
 eStIvWXX1IRma9OJUNg0ct5Y2NXG4TFZ_BHNep7nCbzbaKHxiu6Ckwimk4tDNzuN5WuSzARarYw5
 PTxoUq6kN9sfQ6p5CZpmpxhMKbTDv89NN7Rkc1zYuVmZvb2xdcUjxpna5Diz1GL_PzwyNAUc28Ht
 F1HWH0BSwUIQ8E3RvX79mZ6aly5iJuWqLTs6KKOhpA600ctelpAyqVIYtALTDq_wKZcY8y6ZTK7i
 89zfSV6rAuUhOv3krwu26Y3AxM1DLyo2.2Jy6C24Ym3gQkNjr2xTXGKYG81H9bpDHK1SKN.B8fHH
 Lt8i04gGXixqngZWYEc1IMvtJNwU9GYOP0IUsiS.jXkdvwxFrYLcCs_vbW7ekxz.GVI5JmgPL8v4
 myHzJu2EVXKt.k9nRnrzfvG5daBBdBNd2EHsBsq3TQI6zLxqtAMR6Z5sN13tSanbsnrNviLef1FY
 ancWnB83XizYkw1M_5RwhMj0JXy9u.liWKxixilfsNV7Wyu.1OxdeF59Hf0QWyahWU8NMtSE8d5e
 Lk1vSAsNa.C14SbGkCSFwg8pky8KVlFQoRjcErfiOV9ipVQO41NLbRsqIPJ1p1rai4O0sif1M4Nq
 Ywf_kc7_ZLXxLFWsRC.depSfoIrdG9hW_piA.qwymz3o.9Q9yVY3HW33FKqbjJ4RKe39R3yxZ9uk
 6xs6VhVnVFtPvwpuIpVR_MTLMRpK5MjDVW6iG1pC09Lc2eRaUErg1S0SIEbAPr6GfPjelnzlN4SR
 WjO_fmAXZ4TPJmaeZWgDmNPXTkytfUVnnFfQvoXsG68oByf79cixzNwcVRmdLqimrPnsUISTCxZ4
 9efBD2t.Ph2CCfZOYZ80W5SAxh9TNNXZd3e0F7fEpqB1Dv3CTU.wxuVBk823HXren9VDhUgq5Efh
 4vqJ7h2nY5zysBvJr8ABokH72i4ZAD27NfE9BDy02Qqys.hqfnj8uof0ylbKNGGRklKTExx2HZa9
 _3rekAfry1PpSg2QwAeIm17CWfyBhJiaj.jZR.ZVOasJkSEfqCpTRBru06vmFwssRIipu40fS_L_
 oQqlo2VgZJv9QzRYzlP8dy.ZoJ2AwDhzcGGiFRAl315r_EvxkUnn_u668MMIi4U5Km5HVdwEoEDY
 dM65.14_D4ERe4nvZJxZFt2T2TBXgLJHact.8qIByES1.MSvdTXy1cHzKqdECITVe0Uw3mv0QM.z
 VqY0c_jZ6X1ICPaFu01AtcieNOA9ZsF90_O32hysUQqkuybl4lKraCtmJ61DR.u3Efr0yY77eTT0
 Szc5J
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cca71c90-d104-4fc9-9b53-1f1dbf1e64ac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Dec 2024 19:49:33 +0000
Received: by hermes--production-gq1-5dd4b47f46-mb2l9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 13984d63c985a630996f9b00a6a6b56d;
          Tue, 03 Dec 2024 19:29:13 +0000 (UTC)
Message-ID: <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com>
Date: Tue, 3 Dec 2024 11:29:11 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 LSM List <linux-security-module@vger.kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: LSM: Replace secctx/len pairs with lsm_context
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Paul, do you want a revised patch set for the lsm_context change,
or do you want to stick with what's in dev-staging?

