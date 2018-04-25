From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Wed, 25 Apr 2018 20:01:54 +0900
Subject: KASAN: null-ptr-deref Read in xattr_getsecurity
In-Reply-To: <201804110600.CCF73450.FFOOQtSFOLHMVJ@I-love.SAKURA.ne.jp>
References: <0000000000008d2e0d05697a693d@google.com>
	<9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
	<87o9irw2ad.fsf@xmission.com>
	<201804110600.CCF73450.FFOOQtSFOLHMVJ@I-love.SAKURA.ne.jp>
Message-ID: <334adbb4-bf19-fab6-c426-5f6e2572b4b0@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

OK. Patch was sent to linux.git as 1f5781725dcbb026.

#syz fix: commoncap: Handle memory allocation failure.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
