@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

RUN set -eux; \
    wget -q https://raw.githubusercontent.com/theohbrothers/webize/master/webize -O /usr/local/bin/webize; \
    chmod +x /usr/local/bin/webize


"@

foreach ($c in $VARIANT['_metadata']['components']) {
    switch( $c ) {
        'curl' {
            @'
RUN apk add --no-cache curl


'@
        }
        default {
            throw "No such component: $component"
        }
    }
}

@"
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "webize", "--help" ]
"@
