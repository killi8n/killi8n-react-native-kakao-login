import * as React from 'react';
import { StyleSheet, View, Button } from 'react-native';
import ReactNativeKakaoLogin from '@killi8n/react-native-kakao-login';

export default function App() {
  return (
    <View style={styles.container}>
      <Button
        title="Kakao Login"
        onPress={async () => {
          try {
            const oauthToken = await ReactNativeKakaoLogin.login();
            console.log(oauthToken);
            const profile = await ReactNativeKakaoLogin.getProfile();
            console.log(profile);
          } catch (e) {
            console.error(e);
          }
        }}
      />
      <Button
        title="Kakao Logout"
        onPress={async () => {
          try {
            const result = await ReactNativeKakaoLogin.logout();
            console.log(result);
          } catch (e) {
            console.error(e);
          }
        }}
      />
      <Button
        title="Kakao Unlink"
        onPress={async () => {
          try {
            const unlinkedResult = await ReactNativeKakaoLogin.unlink();
            console.log(unlinkedResult);
          } catch (e) {
            console.error(e);
          }
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
