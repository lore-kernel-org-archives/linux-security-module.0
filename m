From: chandan.vn@samsung.com (CHANDAN VN)
Date: Fri, 01 Jun 2018 21:59:13 +0530
Subject: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set
	and kernfs_security_xattr_set
In-Reply-To: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
References: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
	<1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
	<1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
	<20180531153943.GR1351649@devbig577.frc2.facebook.com>
	<4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
	<20180531161107.GV1351649@devbig577.frc2.facebook.com>
	<20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
	<CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p7>
Message-ID: <20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


>>?I?agree?that?the?fix?can?be?done?simply?by?using?"false"?for?
>>?smack_inode_getsecurity(),?but?what?happens?with?kernfs_node_setsecdata()
>>?and?smack_inode_notifysecctx().?kernfs_node_setsecdata()?is?probably?ignorable
>>?but?smack_inode_notifysecctx()?is?sending?the?"ctx"?to?smack_inode_setsecurity()
>>?and?since?"ctx"?would?be?NULL?because?we?used?"false",?smack_inode_setsecurity()
>>?becomes?dummy.
?
>Thank?you?for?pointing?this?out.?You're?right,?there's?more
>at?issue?here?than?changing?the?alloc?flag?will?fix.?I?think
>that?calling?smack_inode_getsecurity()?from?smack_inode_getsecctx()
>is?making?the?code?more?complicated?than?it?needs?to?be.?I?will
>have?a?patch?shortly.

If you think the patch would take time or is complicated, I suggest that the kfree() fix should go
to fix the leaks for now.?
?
?
?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
