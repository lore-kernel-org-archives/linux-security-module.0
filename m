From: dhowells@redhat.com (David Howells)
Date: Thu, 09 Nov 2017 21:54:19 +0000
Subject: [RFC][PATCH] Lock down ftrace
In-Reply-To: <20171109130329.3de3f41a@gandalf.local.home>
References: <20171109130329.3de3f41a@gandalf.local.home>
	<11100.1510245732@warthog.procyon.org.uk>
Message-ID: <2790.1510264459@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:

> Actually, I see it being enabled with DYNAMIC_FTRACE not set. Calling
> into sysctl and enabling ftrace_enable, will allow the
> ftrace_trace_function to be set to something other than ftrace_stub
> again, allowing for static function tracing to run too.

Hmmm...  Okay, I'm not sure what the sysctl achieves in non-dynamic mode.
Some of the functions used by ftrace_enable_sysctl() are stubbed out in that
case.  I was thinking that was stubbed out also, but apparently not.

Anyway, ftrace_enable_sysctl() is also prohibited in lockdown mode.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
