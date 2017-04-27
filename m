From: dhowells@redhat.com (David Howells)
Date: Thu, 27 Apr 2017 14:57:13 +0100
Subject: [PATCH v4 4/4] KEYS: Print insert-sys-cert information to stdout
	instead of stderr
In-Reply-To: <1492727320-26194-5-git-send-email-mkayaalp@linux.vnet.ibm.com>
References: <1492727320-26194-5-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
Message-ID: <13506.1493301433@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com> wrote:

> +#define info(format, args...) fprintf(stdout, "INFO:    " format, ## args)

Btw, you really ought to be using standard varargs macros:

	#define info(format, ...) fprintf(stdout, "INFO:    " format, ##__VA_LIST__)

But don't worry about that for now.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
